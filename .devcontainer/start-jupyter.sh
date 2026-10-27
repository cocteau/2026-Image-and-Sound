#!/bin/bash
# Starts JupyterLab when the codespace starts (and again whenever the editor
# reconnects, if it isn't running). It opens in its own browser tab
# (port 8888). If it doesn't appear, read /tmp/jupyterlab.log.

cd "$(dirname "$0")/.." || exit 1
source .devcontainer/claude-env.sh
export PATH="$HOME/.local/bin:$PATH"

up() { curl -s -o /dev/null http://127.0.0.1:8888/api; }

# If this script is already running, wait for it to finish first.
exec 9> /tmp/jupyterlab.lock
flock 9

# Already running? Nothing to do.
if up; then exit 0; fi

echo "$(date) starting JupyterLab" >> /tmp/jupyterlab.log

# The port is private to the codespace's owner, so no Jupyter password.
nohup setsid python3 -m jupyterlab \
  --no-browser --ip=0.0.0.0 --port=8888 \
  --ServerApp.token='' --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --ServerApp.root_dir="$PWD" \
  >> /tmp/jupyterlab.log 2>&1 < /dev/null &
disown

# Wait until it answers, so setup doesn't finish before JupyterLab does.
for _ in $(seq 60); do
  if up; then echo "JupyterLab is up on port 8888"; exit 0; fi
  sleep 1
done
echo "JupyterLab did not start; see /tmp/jupyterlab.log"
