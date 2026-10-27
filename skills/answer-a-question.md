---
name: answer-a-question
description: Use when the student asks a question about the data (how many, which, how much, is there a difference, what does X look like). Adds Question, Plan, Compute and Check cells to their notebook.
---

# Answer a question about the data

Add these cells to the end of the student's open notebook, in order.

1. **Markdown: Question.** Restate the question precisely. Name the columns
   you will use and define any vague word ("most", "average", "recent").
2. **Markdown: Plan.** Two or three sentences: how you will answer it, and
   any assumption you had to make (missing values, which rows count, what a
   column means). If an assumption matters, ask the student before going on.
3. **Markdown + code: Compute.** One sentence saying exactly what the code
   computes, then the shortest readable pandas code that answers it. End the
   cell with the result as the last line, so it displays.
4. **Markdown + code: Check.** One sentence saying how this checks the answer
   differently, then the check code. Follow "What counts as a check" in
   the course rules.
5. **Markdown: Claim.** A cell with only `**Claim:** ` for the student to
   complete. Do not fill it in.

Then tell the student, in the chat:

- what a correct result should roughly look like
- that they should read each cell, run it, and compare Compute with Check
- that if the two disagree, the disagreement is the interesting part

If the question needs a chart, follow the `make-a-chart` skill for that cell.
