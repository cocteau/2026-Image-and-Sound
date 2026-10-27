#!/bin/bash
# Starts JupyterLab every time the codespace starts. It opens in its own
# browser tab (port 8888). If it doesn't appear, read /tmp/jupyterlab.log.

cd "$(dirname "$0")/.." || exit 1
source .devcontainer/claude-env.sh

# Already running (e.g. this script ran twice)? Nothing to do.
if curl -s -o /dev/null http://127.0.0.1:8888/api; then exit 0; fi

# The port is private to the codespace's owner, so no Jupyter password.
nohup setsid jupyter lab \
  --no-browser --ip=0.0.0.0 --port=8888 \
  --ServerApp.token='' --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --ServerApp.root_dir="$PWD" \
  > /tmp/jupyterlab.log 2>&1 < /dev/null &
