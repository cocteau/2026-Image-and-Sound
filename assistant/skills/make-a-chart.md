---
name: make-a-chart
description: Use when the student asks for a chart, plot, graph or visual, or when a question is best answered with one.
---

# Make a chart

Use matplotlib (pandas `.plot` is fine). One chart per cell.

- **Pick the simple form.** Comparing groups: bar chart. Change over time:
  line chart. Relationship between two numbers: scatter plot. Distribution of
  one number: histogram.
- **Title says what it shows**, plainly (e.g. "Body mass by species"), not
  what the student should conclude.
- **Label both axes, with units** ("Body mass (g)").
- **Show how many.** Put the number of rows behind the chart in the title or
  a note, and say how many were left out for missing values.
- **Don't distort.** Bar charts start at zero. Don't use 3D, dual axes, or
  pie charts.
- **Keep it readable.** Default colors are fine. Use a legend only when there
  is more than one series.

In the markdown cell above the chart, say what each mark represents (one dot
= one penguin, one bar = one species' average).

Then, in the chat, ask the student what they see before telling them. The
chart is evidence for their claim, not a substitute for it.
