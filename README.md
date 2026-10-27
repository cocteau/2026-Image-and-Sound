# Exploring data with Claude

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

## Getting started

1. **Click the button above.** GitHub asks for a key: paste the key your
   instructor gave you (it starts with `sk-or-`) into `OPENROUTER_API_KEY`.
   Click **Create codespace**.
2. **Wait** a few minutes the first time while it sets up. A code editor
   opens first. **Ignore it.** When setup finishes, **JupyterLab** opens in
   a second browser tab. That's where you work.
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
| `CLAUDE.md` | The rules Claude follows in this course. |
| `.claude/skills/` | Step-by-step instructions Claude uses for answering questions, reviewing claims, and making charts. |

## If something goes wrong

- **The JupyterLab tab never opened** (your browser may have blocked it). In
  the code editor, click the **Ports** tab at the bottom, then the globe icon
  next to **JupyterLab (8888)**.
- **Claude says you're not authenticated, or doesn't answer.** Your key
  didn't reach it. Go to
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
(`.devcontainer/start-jupyter.sh`, log in `/tmp/jupyterlab.log`). Its chat
panel is Jupyter AI, which runs Claude Code behind the scenes and gives it
tools that edit and run cells in the open notebook. Claude's requests go
through OpenRouter (`.devcontainer/claude-env.sh`, which also sets the
model). The VS Code tab still works as a backup, with its own Claude panel.

**Extending it:**

- **New datasets:** add files to `data/` and a notebook that loads them.
- **Change how Claude behaves:** edit `CLAUDE.md` (rules for everything) or
  a skill in `.claude/skills/` (one task). Changes apply the next time a
  student starts a Claude conversation. Students can write their own skills
  too.
- **New skill:** add `.claude/skills/<name>/SKILL.md` with a `name` and a
  `description` saying when Claude should use it.
- **More Python packages:** add them to `requirements.txt`. Existing
  codespaces need a rebuild (Command Palette → *Codespaces: Rebuild
  Container*).
- **Faster first start:** turn on prebuilds in the repository's
  Settings → Codespaces.
