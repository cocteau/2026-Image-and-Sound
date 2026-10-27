# 2026 Image and Sound

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

1. Click the button. GitHub asks for `OPENROUTER_API_KEY`: paste your
   OpenRouter key (it starts with `sk-or-`). Click **Create codespace**.
2. When setup finishes, JupyterLab opens in a new tab. If it doesn't, open
   the **Ports** tab and click the globe icon next to **JupyterLab (8888)**.
3. Open `notebooks/01-first-look.ipynb`.
4. For the AI assistant, click the chat icon in JupyterLab's left sidebar,
   then **New chat**. It uses the latest Claude Opus through OpenRouter.

| Path | What it is |
|---|---|
| `notebooks/01-first-look.ipynb` | An example notebook (Palmer penguins) |
| `data/penguins.csv` | The example data |
| `skills/answer-a-question.md` | An example skill file (the assistant doesn't read it on its own) |

If the chat answers with an error, check the codespace's terminal: the
startup messages say whether the OpenRouter key works.
