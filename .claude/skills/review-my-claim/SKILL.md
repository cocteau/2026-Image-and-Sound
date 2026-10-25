---
name: review-my-claim
description: Use when the student asks you to check, review or critique a claim, conclusion or finding, or to add a claim to the claims notebook.
---

# Review the student's claim

## 1. Review it

Read the claim and every cell it depends on, including the outputs the
student got. Then answer these questions, briefly and in plain language:

1. **Do the numbers match?** Does every number in the claim appear in, or
   follow from, an output in the notebook? Quote the output it came from.
2. **Did the check pass?** Do the Compute and Check results agree? If the
   check was not run, or doesn't really test the answer, say so.
3. **Does it say more than the data shows?** Watch for:
   - cause and effect from a comparison ("because", "leads to", "makes")
   - generalizing beyond the rows analyzed (other years, places, groups)
   - "most", "many", "rarely" without a number behind them
   - percentages without the count they are a percentage of
   - small groups or missing values that could change the answer
4. **What would change your mind?** Suggest one more check that could
   contradict the claim.

Finish with one line: **Supported**, **Partly supported**, or **Not
supported**, and why.

Add your review as a markdown cell directly below the claim, headed
`**Review:**`. Do not rewrite the claim; the student revises it.

## 2. Add it to the claims notebook

When the claim is supported (or the student has revised it), add a new
section at the end of `notebooks/claims.ipynb`, following the existing ones:

- a markdown cell: `## Claim N`, the claim word for word, and `**From:**`
  the notebook it came from
- a code cell with one `check(...)` line for **every** number, ranking, or
  comparison in the claim
- a markdown cell `**Review:**` with your one-line verdict

The check cell must start from the raw data loaded at the top of the claims
notebook. If the claim uses a data file not loaded there yet, add a line
loading it to the setup cell. Do not copy code from the analysis notebook:
compute each number again, by a different route where you can (for example
`pivot_table` instead of `groupby`, or a filter and `len` instead of
`value_counts`). Use `tolerance` only as wide as the claim's own rounding.

Then tell the student to run the cell. If anything prints FAIL, the claim
needs fixing before it counts.
