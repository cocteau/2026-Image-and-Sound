"""The %ask magic.

%ask <question> sends your question to the course model, together with
  * the rules in your skills/ folder (re-read on every ask, so edits apply at once)
  * a short description of the tables you have loaded in this notebook.

It never runs anything itself. It shows you the plan, what the code means and
what you should expect, then puts the code into a NEW CELL below for you to
read and run. Every exchange is appended to ask_log.jsonl in your repo.

Other magics:
  %skills   list the skill files the helper is currently following
"""

from __future__ import annotations

import datetime as _dt
import json
import os
import pathlib
import re

BASE_RULES = """You are a helper in a beginner data-analysis course for journalists.
The student will read and run your code themselves. Your job is to make the
computation easy to read and easy to check, not to impress.

Always reply with ONE JSON object and nothing else, with these keys:
  "plan":     1-3 sentences: how you will answer, in plain English.
  "code":     short Python (pandas) that computes the answer, using the
              student's existing variables. Prefer few, simple lines.
              End with an expression that displays the result.
  "meaning":  ONE sentence that says exactly what the code counts or sums,
              including every filter and definition it uses
              (e.g. "committees whose CMTE_TP is O, U, V or W").
  "check":    short Python that tests the result a DIFFERENT way
              (recount another way, compare to a known value, check a
              total is plausible, show a few raw rows). Use functions from
              the `checks` module when they fit.
  "expect":   what a correct result should roughly look like, so the student
              can notice when it does not.
  "unsure":   anything you had to assume or could not know (column meanings,
              definitions). Empty string if nothing.

Follow the student's skill files below. If they conflict with these rules,
the skill files win, except that you must always reply in the JSON format.
"""


def _repo_root() -> pathlib.Path:
    here = pathlib.Path.cwd().resolve()
    for p in [here, *here.parents]:
        if (p / "skills").is_dir():
            return p
    return here


def _load_skills(root: pathlib.Path) -> list[tuple[str, str]]:
    folder = root / "skills"
    if not folder.is_dir():
        return []
    out = []
    for f in sorted(folder.glob("*.md")):
        out.append((f.name, f.read_text(encoding="utf-8")))
    for f in sorted(folder.glob("*/SKILL.md")):  # later: Claude Code-style folders
        out.append((f"{f.parent.name}/SKILL.md", f.read_text(encoding="utf-8")))
    return out


def _describe_namespace(ns: dict) -> str:
    try:
        import pandas as pd
    except ImportError:  # pragma: no cover
        return ""
    parts = []
    for name, val in ns.items():
        if name.startswith("_") or not isinstance(val, pd.DataFrame):
            continue
        cols = ", ".join(f"{c} ({t})" for c, t in val.dtypes.astype(str).items())
        sample = val.head(3).to_string(max_cols=20, max_colwidth=30)
        parts.append(f"DataFrame `{name}`: {len(val):,} rows\nColumns: {cols}\nFirst rows:\n{sample}")
    return "\n\n".join(parts) if parts else "(no tables loaded yet)"


def _parse_json(text: str) -> dict:
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        m = re.search(r"\{.*\}", text, re.S)
        if m:
            return json.loads(m.group(0))
        raise


def _client():
    from openai import OpenAI

    key = os.environ.get("OPENROUTER_API_KEY") or os.environ.get("ASK_API_KEY")
    if not key:
        raise RuntimeError(
            "No course key found. In Codespaces, add OPENROUTER_API_KEY as a "
            "Codespaces secret for this repo, then rebuild or restart the codespace."
        )
    return OpenAI(base_url=os.environ.get("ASK_BASE_URL", "https://openrouter.ai/api/v1"), api_key=key)


def build_cell(question: str, reply: dict) -> str:
    q = " ".join(question.split())
    lines = [
        f"# ASK:   {q}",
        f"# CLAIM: {reply.get('meaning', '').strip()}",
        "#        Read the code below. Does it compute exactly that? Is that what you meant?",
        reply.get("code", "").strip(),
        "",
        "# CHECK: the same answer, tested a different way",
        reply.get("check", "").strip(),
    ]
    return "\n".join(lines).rstrip() + "\n"


def ask(question: str, ns: dict | None = None, *, model: str | None = None, client=None) -> dict:
    """Ask the course model. Returns the parsed reply (and logs it)."""
    root = _repo_root()
    skills = _load_skills(root)
    system = BASE_RULES + "".join(f"\n\n--- skill: {n} ---\n{t}" for n, t in skills)
    user = f"Tables in the notebook:\n{_describe_namespace(ns or {})}\n\nQuestion: {question}"
    model = model or os.environ.get("ASK_MODEL", "deepseek/deepseek-chat")
    client = client or _client()

    resp = client.chat.completions.create(
        model=model,
        messages=[{"role": "system", "content": system}, {"role": "user", "content": user}],
        temperature=0.2,
    )
    raw = resp.choices[0].message.content
    reply = _parse_json(raw)

    with open(root / "ask_log.jsonl", "a", encoding="utf-8") as f:
        f.write(json.dumps({
            "time": _dt.datetime.now().isoformat(timespec="seconds"),
            "model": model,
            "skills": [n for n, _ in skills],
            "question": question,
            "reply": reply,
        }) + "\n")
    return reply


def _show(question: str, reply: dict) -> None:
    from IPython.display import Markdown, display

    md = [f"**Plan.** {reply.get('plan', '')}",
          f"**What the code claims to compute.** {reply.get('meaning', '')}",
          f"**What a correct answer should look like.** {reply.get('expect', '')}"]
    if reply.get("unsure"):
        md.append(f"**Assumptions to verify.** {reply['unsure']}")
    md.append("*The code is in the new cell below. Read it before you run it.*")
    display(Markdown("\n\n".join(md)))


def load_ipython_extension(ip) -> None:
    def ask_magic(line, cell=None):  # noqa: ANN001
        question = (line + "\n" + (cell or "")).strip()
        if not question:
            print("Usage:  %ask how many committees are super PACs?")
            return
        reply = ask(question, ip.user_ns)
        _show(question, reply)
        ip.set_next_input(build_cell(question, reply), replace=False)

    def skills_magic(line):  # noqa: ANN001
        found = _load_skills(_repo_root())
        if not found:
            print("No skill files yet. Add markdown files to skills/.")
        for name, text in found:
            first = next((l for l in text.splitlines() if l.startswith("description:")), "")
            print(f"- {name}  {first.replace('description:', '').strip()}")

    # Show the value of every bare expression in a cell, not just the last one,
    # so an answer and its check both appear.
    ip.ast_node_interactivity = "all"
    ip.register_magic_function(ask_magic, "line_cell", "ask")
    ip.register_magic_function(skills_magic, "line", "skills")
