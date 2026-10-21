# Data

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/cocteau/2026-Image-and-Sound)

Click the button. The first time, GitHub asks for a key. Paste the course key
your instructor gave you into `OPENROUTER_API_KEY` and leave the other blank.

**Make it open as a notebook:** go to github.com/settings/codespaces and set
*Editor preference* to **JupyterLab**. You only do this once.

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
