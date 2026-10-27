#!/bin/bash
# Starts JupyterLab when the codespace starts (and checks again whenever the
# editor reconnects). It opens in its own browser tab (port 8888).
# If it doesn't appear, read /tmp/jupyterlab.log.

cd "$(dirname "$0")/.." || exit 1
export PATH="$HOME/.local/bin:$PATH"

# The chat reaches Claude only through OpenRouter, with the OPENROUTER_API_KEY
# secret (the model is set in .jupyter/personas/course_persona.py). Hide any
# other AI keys the student may have as Codespaces secrets, so nothing can go
# around OpenRouter.
unset ANTHROPIC_API_KEY ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL OPENAI_API_KEY

up() { curl -s -o /dev/null http://127.0.0.1:8888/api; }
running() { pgrep -f "^python3 -m jupyterlab" > /dev/null; }

# If this script is already running, wait (at most 5 minutes) for it.
exec 9> /tmp/jupyterlab.lock
flock -w 300 9

# Already answering? Nothing to do.
if up; then exit 0; fi

# Check the OpenRouter key, so a bad key shows up here, not as a confusing
# error in the chat.
if [ -z "$OPENROUTER_API_KEY" ]; then
  echo "WARNING: no OPENROUTER_API_KEY secret. The chat won't work until you add it."
else
  reply=$(curl -s -m 15 https://openrouter.ai/api/v1/key \
            -H "Authorization: Bearer $OPENROUTER_API_KEY")
  if echo "$reply" | grep -q '"data"'; then
    echo "OpenRouter key works."
  elif [ -z "$reply" ]; then
    echo "WARNING: couldn't reach OpenRouter to check the key."
  else
    echo "WARNING: OpenRouter rejected the OPENROUTER_API_KEY secret: $reply"
  fi
fi

# Start it only if it isn't already running. (On a brand-new codespace it
# can take a few minutes to answer; don't start a second copy meanwhile.)
if ! running; then
  echo "$(date) starting JupyterLab" >> /tmp/jupyterlab.log
  # The port is private to the codespace's owner, so no Jupyter password.
  nohup setsid python3 -m jupyterlab \
    --no-browser --ip=0.0.0.0 --port=8888 --ServerApp.port_retries=0 \
    --ServerApp.token='' --ServerApp.password='' \
    --ServerApp.allow_origin='*' \
    --ServerApp.root_dir="$PWD" \
    --PersonaManager.default_persona_id="jupyter-ai-personas::course_persona::CourseAssistant" \
    >> /tmp/jupyterlab.log 2>&1 < /dev/null 9>&- &
  disown
fi

# Wait until it answers, so setup doesn't finish before JupyterLab does.
for _ in $(seq 240); do
  if up; then echo "JupyterLab is up on port 8888"; exit 0; fi
  sleep 1
done
echo "JupyterLab did not start; see /tmp/jupyterlab.log"
