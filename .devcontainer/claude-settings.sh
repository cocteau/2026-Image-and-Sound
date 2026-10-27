#!/bin/bash
# Writes Claude's own settings file (~/.claude/settings.json) so that every
# Claude in the codespace (the VS Code panel, the JupyterLab chat and the
# terminal) sends its requests through OpenRouter with this student's key.
# Runs every time the codespace starts.

cd "$(dirname "$0")/.." || exit 1
source .devcontainer/claude-env.sh

if [ -z "$OPENROUTER_API_KEY" ]; then
  echo "No OPENROUTER_API_KEY secret found; Claude won't work until it's added."
fi

mkdir -p ~/.claude
python3 - <<'PY'
import json, os, pathlib
names = [
    "ANTHROPIC_BASE_URL", "ANTHROPIC_AUTH_TOKEN", "ANTHROPIC_API_KEY",
    "ANTHROPIC_MODEL", "ANTHROPIC_DEFAULT_SONNET_MODEL",
    "ANTHROPIC_DEFAULT_OPUS_MODEL", "ANTHROPIC_DEFAULT_HAIKU_MODEL",
    "CLAUDE_CODE_SUBAGENT_MODEL", "ENABLE_TOOL_SEARCH",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC",
]
path = pathlib.Path.home() / ".claude" / "settings.json"
settings = json.loads(path.read_text()) if path.exists() else {}
settings.setdefault("env", {}).update({n: os.environ.get(n, "") for n in names})
path.write_text(json.dumps(settings, indent=2))
PY
chmod 600 ~/.claude/settings.json
echo "Claude is set up to use OpenRouter."
