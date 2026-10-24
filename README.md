# Data

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

## Getting started

1. **First, make it open in JupyterLab.** Go to
   [github.com/settings/codespaces](https://github.com/settings/codespaces)
   and set *Editor preference* to **JupyterLab**. Do this *before* step 2.
   You only do it once.
2. **Click the button above.** GitHub asks for a key. Paste the course key
   your instructor gave you into `OPENROUTER_API_KEY` and leave
   `ANTHROPIC_API_KEY` blank. Then click **Create codespace**.
3. **Wait for it to finish setting up** (a few minutes the first time). When
   JupyterLab appears, open `notebooks/` in the file browser on the left.

To come back later, go to [github.com/codespaces](https://github.com/codespaces)
and click your codespace. Don't click the button again, which would make a
second one.

### If something goes wrong

- **It opened in VS Code instead of JupyterLab.** Go to
  [github.com/codespaces](https://github.com/codespaces), click **…** next to
  your codespace, and choose **Open in → JupyterLab**. Then do step 1 so it
  sticks.
- **You skipped the key, or `%ask` says no key is set.** Add it at
  [github.com/settings/codespaces](https://github.com/settings/codespaces)
  under *Codespaces secrets*: name `OPENROUTER_API_KEY`, your key as the
  value, and this repository selected. Then **restart the codespace**
  (**…** → *Stop codespace*, then open it again). Keys are only read at
  startup.

## What's in here

| Folder | What it is | Who writes it |
|---|---|---|
| `notebooks/` | Your analyses: question → code → evidence → check | You |
| `skills/` | Plain-English rules the AI helper must follow | You, starting from ours |
| `checks/` | Small tested functions that check results | Us at first, then you |
| `log.md` | Every claim you make, and how you verified it | You |
| `ask_log.jsonl` | Every question you asked the helper, and its answer | Written automatically |

## Using the helper

In a notebook:

```
%load_ext datakit
%ask how many committees in this file are super PACs?
```

The helper explains its plan, says exactly what its code claims to compute,
and puts the code — plus a check — in a new cell. **It never runs anything.
You read it, then you run it.**

`%skills` lists the rules it is following. Edit a file in `skills/` and the
next `%ask` follows the new rule.
