#!/usr/bin/env bash
# Unregister First Flight from the local Codex plugin marketplace.

set -euo pipefail

PLUGIN_NAME="first-flight"
MARKETPLACE_FILE="${FIRST_FLIGHT_MARKETPLACE_FILE:-$HOME/.agents/plugins/marketplace.json}"
MARKETPLACE_NAMES=("candobear-agentlab" "candobear-local")

usage() {
  cat <<EOF
Unregister First Flight from Codex.

This only removes the marketplace entry and moves Codex's plugin cache aside.
Your local checkout of the repo is left untouched — delete it yourself if needed.

Usage:
  script/uninstall-codex.sh [options]

Options:
  --marketplace PATH     Codex marketplace JSON. Default: $MARKETPLACE_FILE
  -h, --help             Show this help.

Environment overrides:
  FIRST_FLIGHT_MARKETPLACE_FILE
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --marketplace)
      MARKETPLACE_FILE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required." >&2
  exit 1
fi

export PLUGIN_NAME MARKETPLACE_FILE
python3 <<'PY'
import json
import os
from pathlib import Path
import sys

plugin_name = os.environ["PLUGIN_NAME"]
marketplace_file = Path(os.environ["MARKETPLACE_FILE"]).expanduser().resolve()

if not marketplace_file.exists():
    print(f"Codex marketplace does not exist: {marketplace_file}")
    sys.exit(0)

try:
    data = json.loads(marketplace_file.read_text(encoding="utf-8"))
except json.JSONDecodeError as exc:
    sys.exit(f"Invalid JSON in {marketplace_file}: {exc}")

plugins = data.get("plugins", [])
kept = [plugin for plugin in plugins if plugin.get("name") != plugin_name]

if len(kept) == len(plugins):
    print(f"No {plugin_name} entry found in {marketplace_file}")
else:
    data["plugins"] = kept
    marketplace_file.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Removed {plugin_name} from Codex marketplace: {marketplace_file}")
PY

# Move Codex's plugin cache aside so the next install picks up clean state.
CACHE_ROOT="$HOME/.codex/plugins/cache"
CACHE_RETIRED_ROOT="$HOME/.codex/plugins/cache-retired"

retire_cache_dir() {
  local cache_dir="$1"
  local marketplace="$2"

  if [[ ! -d "$cache_dir" ]]; then
    return
  fi

  local stamp
  stamp="$(date +%Y%m%d-%H%M%S)"
  local retired_dir="$CACHE_RETIRED_ROOT/$marketplace/$PLUGIN_NAME-$stamp"
  local suffix=1

  while [[ -e "$retired_dir" ]]; do
    retired_dir="$CACHE_RETIRED_ROOT/$marketplace/$PLUGIN_NAME-$stamp-$suffix"
    suffix=$((suffix + 1))
  done

  mkdir -p "$(dirname "$retired_dir")"
  echo "🧹 Moving Codex plugin cache aside:"
  echo "   from: $cache_dir"
  echo "   to:   $retired_dir"
  mv "$cache_dir" "$retired_dir"
}

for cache_marketplace_name in "${MARKETPLACE_NAMES[@]}"; do
  retire_cache_dir "$CACHE_ROOT/$cache_marketplace_name/$PLUGIN_NAME" "$cache_marketplace_name"
done

if [[ "${FIRST_FLIGHT_UNINSTALL_INTERNAL:-0}" != "1" ]]; then
  echo ""
  echo "First Flight is unregistered from Codex."
  echo "Restart Codex to refresh the plugin UI."
fi
