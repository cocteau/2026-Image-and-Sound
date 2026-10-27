---
name: answer-a-question
description: Use when the student asks a question about the data (how many, which, how much, is there a difference, what does X look like). Adds Question, Plan, Compute and Check cells to their notebook.
---

# Answer a question about the data

**Skip these steps when the student asks for something quick.** If they say
"just", "quick", "only", "skip the steps", or simply ask for a plot or a
table without asking a question, do only that: one short markdown line
saying what the cell shows, then the code. No Question, Plan, Check or Claim
cells. Go back to the full steps the next time they ask a real question
about the data.

Otherwise, add these cells to the end of the student's open notebook, in order.

1. **Markdown: Question.** Restate the question precisely. Name the columns
   you will use and define any vague word ("most", "average", "recent").
2. **Markdown: Plan.** Two or three sentences: how you will answer it, and
   any assumption you had to make (missing values, which rows count, what a
   column means). If an assumption matters, ask the student before going on.
3. **Markdown + code: Compute.** One sentence saying exactly what the code
   computes, then the shortest readable pandas code that answers it. End the
   cell with the result as the last line, so it displays.
4. **Markdown + code: Check.** One sentence saying how this checks the answer
   differently, then the check code. A check must be able to disagree with
   the answer: compute the same number a second, independent way, confirm the
   parts add up to the whole, or look at the raw rows behind the result.
   Re-running the same code is not a check.
5. **Markdown: Claim.** A cell containing exactly
   `**Claim:** *(Your turn: one sentence on what you conclude, with the numbers that support it.)*`
   for the student to complete. Do not fill it in.

Then tell the student, in the chat:

- what a correct result should roughly look like
- that they should read each cell, run it, and compare Compute with Check
- that if the two disagree, the disagreement is the interesting part

If the question needs a chart, make one simple chart per cell, with a title
that says what it shows and both axes labeled with units.
