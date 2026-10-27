#!/bin/bash
# Starts JupyterLab in the background when the codespace starts.
# It opens in its own tab; if not, use the Ports tab: JupyterLab (8888),
# globe icon. Log: /tmp/jupyterlab.log
#
# All AI goes through OpenRouter, paid with the OPENROUTER_API_KEY secret.

cd "$(dirname "$0")/.." || exit 1

# The model: the latest Claude Opus, through OpenRouter.
MODEL="~anthropic/claude-opus-latest"

# Say plainly whether the OpenRouter key works.
if [ -z "$OPENROUTER_API_KEY" ]; then
  echo "WARNING: no OPENROUTER_API_KEY secret; the AI won't work."
elif curl -s -m 15 https://openrouter.ai/api/v1/key \
       -H "Authorization: Bearer $OPENROUTER_API_KEY" | grep -q '"data"'; then
  echo "OpenRouter key works."
else
  echo "WARNING: OpenRouter didn't accept the OPENROUTER_API_KEY secret."
fi

# The Claude agent in the chat (Claude Code) reaches Claude through OpenRouter.
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_MODEL="$MODEL"
export ANTHROPIC_DEFAULT_OPUS_MODEL="~anthropic/claude-opus-latest"
export ANTHROPIC_DEFAULT_SONNET_MODEL="~anthropic/claude-sonnet-latest"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="~anthropic/claude-haiku-latest"
# Load Jupyter's notebook tools up front, so Claude uses them to edit notebooks.
export ENABLE_TOOL_SEARCH=false

# %%ai in notebooks: loaded automatically, with the same default model.
mkdir -p ~/.ipython/profile_default
cat > ~/.ipython/profile_default/ipython_config.py <<EOF
c.InteractiveShellApp.extensions = ["jupyter_ai_magic_commands"]
# Hide the model library's debug messages above every %%ai answer.
c.InteractiveShellApp.exec_lines = ["import litellm; litellm.suppress_debug_info = True"]
c.AiMagics.initial_aliases = {
    "claude": {"target": "openrouter/$MODEL", "api_base": None, "api_key_name": None},
}
c.AiMagics.initial_language_model = "claude"
EOF

nohup setsid python3 -m jupyterlab \
  --no-browser --ip=0.0.0.0 --port=8888 \
  --ServerApp.token='' --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --JupyternautExtension.initial_language_model="openrouter/$MODEL" \
  --MCPExtensionApp.mcp_name="notebook" \
  --PersonaManager.default_persona_id="jupyter-ai-personas::jupyter_ai_jupyternaut::JupyternautPersona" \
  > /tmp/jupyterlab.log 2>&1 < /dev/null &
disown

# Wait until it answers before finishing setup.
for _ in $(seq 240); do
  curl -s -o /dev/null http://127.0.0.1:8888/api && exit 0
  sleep 1
done
echo "JupyterLab did not start; see /tmp/jupyterlab.log"
