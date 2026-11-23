#!/usr/bin/env bash
# Install First Flight as a local Codex plugin from this checkout.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PLUGIN_NAME="first-flight"
PLUGIN_DIR="${FIRST_FLIGHT_PLUGIN_DIR:-$REPO_ROOT}"
MARKETPLACE_FILE="${FIRST_FLIGHT_MARKETPLACE_FILE:-$HOME/.agents/plugins/marketplace.json}"
MARKETPLACE_NAME="${FIRST_FLIGHT_MARKETPLACE_NAME:-candobear-agentlab}"
MARKETPLACE_DISPLAY_NAME="${FIRST_FLIGHT_MARKETPLACE_DISPLAY_NAME:-CandoBear AgentLab}"

usage() {
  cat <<EOF
Install First Flight for Codex from this local checkout.

Usage:
  script/install-codex.sh [options]

Options:
  --plugin-dir PATH      Plugin checkout path. Default: $PLUGIN_DIR
  --marketplace PATH     Codex marketplace JSON. Default: $MARKETPLACE_FILE
  -h, --help             Show this help.

Environment overrides:
  FIRST_FLIGHT_PLUGIN_DIR
  FIRST_FLIGHT_MARKETPLACE_FILE
  FIRST_FLIGHT_MARKETPLACE_NAME
  FIRST_FLIGHT_MARKETPLACE_DISPLAY_NAME
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --plugin-dir)
      PLUGIN_DIR="$2"
      shift 2
      ;;
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

mkdir -p "$(dirname "$MARKETPLACE_FILE")"

if [[ ! -d "$PLUGIN_DIR" ]]; then
  echo "Plugin directory does not exist: $PLUGIN_DIR" >&2
  exit 1
fi

if [[ ! -f "$PLUGIN_DIR/.codex-plugin/plugin.json" ]]; then
  echo "Missing Codex plugin manifest: $PLUGIN_DIR/.codex-plugin/plugin.json" >&2
  exit 1
fi

if [[ ! -d "$PLUGIN_DIR/skills" ]]; then
  echo "Missing skills directory: $PLUGIN_DIR/skills" >&2
  exit 1
fi

echo "Uninstalling existing First Flight Codex plugin entries..."
FIRST_FLIGHT_UNINSTALL_INTERNAL=1 "$SCRIPT_DIR/uninstall-codex.sh" --marketplace "$MARKETPLACE_FILE"

export PLUGIN_NAME PLUGIN_DIR MARKETPLACE_FILE MARKETPLACE_NAME MARKETPLACE_DISPLAY_NAME
python3 <<'PY'
import json
import os
from pathlib import Path
import sys

plugin_name = os.environ["PLUGIN_NAME"]
plugin_dir = Path(os.environ["PLUGIN_DIR"]).expanduser().resolve()
marketplace_file = Path(os.environ["MARKETPLACE_FILE"]).expanduser().resolve()
marketplace_name = os.environ["MARKETPLACE_NAME"]
marketplace_display_name = os.environ["MARKETPLACE_DISPLAY_NAME"]
home = Path.home().resolve()

try:
    rel_plugin_dir = plugin_dir.relative_to(home)
except ValueError:
    sys.exit(f"Plugin directory must be inside $HOME for local Codex marketplace paths: {plugin_dir}")

source_path = "./" + rel_plugin_dir.as_posix()

if marketplace_file.exists():
    try:
        data = json.loads(marketplace_file.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        sys.exit(f"Invalid JSON in {marketplace_file}: {exc}")
else:
    data = {"plugins": []}

data["name"] = marketplace_name
interface = data.setdefault("interface", {})
interface["displayName"] = marketplace_display_name
plugins = data.setdefault("plugins", [])

entry = {
    "name": plugin_name,
    "source": {
        "source": "local",
        "path": source_path
    },
    "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
    },
    "category": "Productivity"
}

for index, plugin in enumerate(plugins):
    if plugin.get("name") == plugin_name:
        plugins[index] = entry
        break
else:
    plugins.append(entry)

marketplace_file.parent.mkdir(parents=True, exist_ok=True)
marketplace_file.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(f"Updated Codex marketplace: {marketplace_file}")
print(f"Registered plugin path: {source_path}")
PY

echo ""
echo "First Flight is installed for Codex."
echo "Restart Codex, then install or enable First Flight from the plugin UI."
