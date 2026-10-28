# 2026 Image and Sound

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

## Getting started

1. Click the button. GitHub asks for `OPENROUTER_API_KEY`: paste the
   OpenRouter key you were given (it starts with `sk-or-`). Click
   **Create codespace**.
2. When setup finishes, JupyterLab opens in a new tab. If it doesn't, open
   the **Ports** tab and click the globe icon next to **JupyterLab (8888)**.
3. Open the `lessons` folder and start with `01-first-look`.

**Set your idle timeout once.** A codespace shuts down after 30 minutes
without activity, and working only in JupyterLab may not count, so your
kernel can seem to "die". At
[github.com/settings/codespaces](https://github.com/settings/codespaces),
set **Default idle timeout** to 240 minutes.

To come back later, go to [github.com/codespaces](https://github.com/codespaces)
and open your codespace. Don't click the button above again, which makes a
second one.

## What's here

| Path | What it is |
|---|---|
| `lessons/` | One folder per lesson, each with its notebook and its data |
| `lessons/01-first-look/` | First lesson: Palmer penguins |
| `.claude/skills/` | Skills: instructions Claude follows in every lesson |

## AI in JupyterLab

- **Chat:** click the chat icon in the left sidebar, then **New chat**. Pick
  **Claude** or **Jupyternaut** in the menu at the bottom left of the chat.
  Both can add and run cells in the open notebook, and ask permission first.
  Want just a plot, without the Question/Plan/Check steps? Say "just".
- **`%%ai` in a cell:** start a cell with `%%ai` and write a question below it.

Everything uses the latest Claude Opus through OpenRouter, paid with the
`OPENROUTER_API_KEY` secret. If the AI answers with an error, check the
codespace's terminal: the startup messages say whether the key works.
