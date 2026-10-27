#!/bin/bash
# Starts JupyterLab in the background when the codespace starts.
# It opens in its own tab; if not, use the Ports tab: JupyterLab (8888),
# globe icon. Log: /tmp/jupyterlab.log

cd "$(dirname "$0")/.." || exit 1

# Jupyter AI's default model: the latest Claude Opus through OpenRouter,
# paid with the OPENROUTER_API_KEY secret.
MODEL="openrouter/~anthropic/claude-opus-latest"

# Say plainly whether the OpenRouter key works.
if [ -z "$OPENROUTER_API_KEY" ]; then
  echo "WARNING: no OPENROUTER_API_KEY secret; the AI chat won't work."
elif curl -s -m 15 https://openrouter.ai/api/v1/key \
       -H "Authorization: Bearer $OPENROUTER_API_KEY" | grep -q '"data"'; then
  echo "OpenRouter key works."
else
  echo "WARNING: OpenRouter didn't accept the OPENROUTER_API_KEY secret."
fi

nohup setsid python3 -m jupyterlab \
  --no-browser --ip=0.0.0.0 --port=8888 \
  --ServerApp.token='' --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --JupyternautExtension.initial_language_model="$MODEL" \
  --PersonaManager.default_persona_id="jupyter-ai-personas::jupyter_ai_jupyternaut::JupyternautPersona" \
  > /tmp/jupyterlab.log 2>&1 < /dev/null &
disown

# Wait until it answers before finishing setup.
for _ in $(seq 240); do
  curl -s -o /dev/null http://127.0.0.1:8888/api && exit 0
  sleep 1
done
echo "JupyterLab did not start; see /tmp/jupyterlab.log"
