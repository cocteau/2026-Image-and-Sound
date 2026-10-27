#!/bin/bash
# Starts JupyterLab in the background when the codespace starts.
# Open it from the Ports tab: JupyterLab (8888), globe icon.
# Log: /tmp/jupyterlab.log

cd "$(dirname "$0")/.." || exit 1

nohup setsid python3 -m jupyterlab \
  --no-browser --ip=0.0.0.0 --port=8888 \
  --ServerApp.token='' --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  > /tmp/jupyterlab.log 2>&1 < /dev/null &
disown

# Wait until it answers before finishing setup.
for _ in $(seq 240); do
  curl -s -o /dev/null http://127.0.0.1:8888/api && exit 0
  sleep 1
done
echo "JupyterLab did not start; see /tmp/jupyterlab.log"
