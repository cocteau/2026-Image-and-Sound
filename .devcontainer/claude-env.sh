# Sends Claude's requests through OpenRouter, paid for with the student's own
# capped key (the OPENROUTER_API_KEY Codespaces secret). Used by JupyterLab's
# Claude chat and by `claude` in the terminal.

export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
export ANTHROPIC_API_KEY=""   # must be empty, or Claude skips OpenRouter

# Sonnet by default: strong and much cheaper than Opus.
export ANTHROPIC_MODEL="~anthropic/claude-sonnet-latest"
export ANTHROPIC_DEFAULT_SONNET_MODEL="~anthropic/claude-sonnet-latest"
export ANTHROPIC_DEFAULT_OPUS_MODEL="~anthropic/claude-opus-latest"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="~anthropic/claude-haiku-latest"
export CLAUDE_CODE_SUBAGENT_MODEL="~anthropic/claude-sonnet-latest"

# Give Claude the notebook tools up front, so it uses them to edit notebooks.
export ENABLE_TOOL_SEARCH=false
# No telemetry, error reports or auto-updates.
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
