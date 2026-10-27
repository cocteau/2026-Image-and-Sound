# Exploring data with Claude

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

## Getting started

1. **Click the button above.** GitHub asks for a key: paste the key your
   instructor gave you (it starts with `sk-or-`) into `OPENROUTER_API_KEY`.
   Click **Create codespace**.
2. **Wait** a few minutes the first time while it sets up. A code editor
   opens first, showing this page. **Ignore the editor.** When setup
   finishes, **JupyterLab** opens in a second browser tab. That's where you
   work. (No second tab? See "If something goes wrong" below.)
3. In JupyterLab, open `notebooks/01-first-look.ipynb` and read it from the
   top.
4. **Open Claude:** click the chat icon (two speech bubbles) in the left
   sidebar, then **New chat**. Claude is already selected; type your question.
   Claude asks your permission (**Yes**) before it changes your notebook.

To come back later, go to [github.com/codespaces](https://github.com/codespaces)
and click your codespace. Don't click the button again, which makes a second
one.

## How we work

You ask questions. Claude writes the code into your notebook. **You** read
it, run it, check it, and decide what it means. Every question goes through
the same six steps:

| Step | Who | What |
|---|---|---|
| Question | Claude | Your question, stated precisely |
| Plan | Claude | How it will answer, and what it assumed |
| Compute | Claude writes, you run | The code that answers it |
| Check | Claude writes, you run | A second, different way to get the answer |
| Claim | **You** | One sentence: what you conclude |
| Review | Claude | Whether your claim holds up |

Before you believe any result: read the sentence above the code, read the
code, run Compute and Check and compare them, and look at a few raw rows.

## The claims notebook

Every claim that survives review goes into `notebooks/claims.ipynb`, with
code that recomputes each of its numbers from the raw data and prints PASS or
FAIL. Ask Claude to "add my claim to the claims notebook", then run the new
cell. Run All at any time to re-check every claim you've made.

## What's in here

| Path | What it is |
|---|---|
| `notebooks/` | Your analyses. `template.ipynb` is a blank starting point. |
| `notebooks/claims.ipynb` | Every claim you make, with code that checks it. |
| `data/` | Data files. Don't edit them; clean data in a notebook instead. |
| `assistant/rules.md` | The rules Claude follows in this course. |
| `assistant/skills/` | Step-by-step instructions Claude uses for answering questions, reviewing claims, and making charts. |

## If something goes wrong

- **The JupyterLab tab never opened** (your browser may have blocked it). In
  the code editor, click the **Ports** tab at the bottom, then the globe icon
  next to **JupyterLab (8888)**.
- **Claude answers with an error, or not at all.** Your key probably didn't
  reach it. In the code editor's **Terminal**, the startup messages say
  whether the key works. To add or fix it, go to
  [github.com/settings/codespaces](https://github.com/settings/codespaces),
  add a secret named `OPENROUTER_API_KEY` with your key (starts with
  `sk-or-`), select this repository, then stop and restart your codespace.
- **Running a cell asks you to pick a kernel.** Choose **Python 3**.

---

## For the instructor

**Setup, once:**

1. If you copy this to another repository, change the badge link above to
   point to it.
2. In [OpenRouter](https://openrouter.ai/settings/keys), add credit and
   create one API key per student, each with its own spending limit.
   Per-student keys let you see each student's usage and revoke one key
   without affecting the others. In each key's settings, consider allowing
   only the Anthropic provider.
3. Make one codespace yourself and run through `01-first-look`, including
   asking Claude one question and asking it to review a claim.

**How it's wired:** JupyterLab starts automatically
(`.devcontainer/start-jupyter.sh`, log in `/tmp/jupyterlab.log`), and checks
the student's OpenRouter key on the way. Its chat is Jupyter AI. "Claude" in
the chat is Jupyter AI's built-in agent with this course's rules added
(`.jupyter/personas/course_persona.py`); it edits and runs cells in the open
notebook through Jupyter AI's notebook tools. The model is the latest Claude
Sonnet, reached through OpenRouter (set in `start-jupyter.sh`).

**Extending it:**

- **New datasets:** add files to `data/` and a notebook that loads them.
- **Change how Claude behaves:** edit `assistant/rules.md` (rules for
  everything) or a file in `assistant/skills/` (one task). Changes apply to
  the next message.
- **New skill:** add a Markdown file to `assistant/skills/`, starting with a
  heading and a line saying when Claude should use it.
- **More Python packages:** add them to `requirements.txt`. Existing
  codespaces need a rebuild (Command Palette → *Codespaces: Rebuild
  Container*).
- **Faster first start:** turn on prebuilds in the repository's
  Settings → Codespaces.
