# 2026 Image and Sound

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

1. Click the button. GitHub asks for `OPENROUTER_API_KEY`: paste your
   OpenRouter key (it starts with `sk-or-`). Click **Create codespace**.
2. When setup finishes, JupyterLab opens in a new tab. If it doesn't, open
   the **Ports** tab and click the globe icon next to **JupyterLab (8888)**.
3. Open `notebooks/01-first-look.ipynb`.

## AI in JupyterLab (Jupyter AI)

- **Chat:** click the chat icon in the left sidebar, then **New chat**. Pick
  **Claude** (Claude Code) or **Jupyternaut** (Jupyter AI's own assistant) in
  the menu at the bottom left of the chat. Both can add and run cells in the
  open notebook, and ask permission first.
- **`%%ai` in a cell:** start a cell with `%%ai` and write a question below it.

All of them use the latest Claude Opus, through OpenRouter, paid with the
`OPENROUTER_API_KEY` secret (set in `.devcontainer/start-jupyter.sh`).

| Path | What it is |
|---|---|
| `notebooks/01-first-look.ipynb` | An example notebook (Palmer penguins) |
| `data/penguins.csv` | The example data |
| `.claude/skills/answer-a-question/SKILL.md` | An example skill. **Claude** in the chat reads it on its own; Jupyternaut doesn't. |

If the AI answers with an error, check the codespace's terminal: the startup
messages say whether the OpenRouter key works.
