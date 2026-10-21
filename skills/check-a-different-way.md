---
name: check-a-different-way
description: Every result gets a second, independent test before anyone believes it
---

# Check a different way

A result is not evidence until it has survived a test that could have failed.

For every result, include a check that uses a different route to the answer.
Good checks, roughly in order of strength:

1. **Known value.** Compare one specific row or total to an outside source
   (for FEC data: the committee's page on fec.gov).
2. **Recount.** Get the same number with different code (a count vs. a sum of
   group counts; a filter vs. value_counts).
3. **Plausible range.** Say in advance what range would be believable, then
   test it.
4. **Look at the rows.** Show a few raw rows that went into the number, and a
   few that were excluded.

A check that only re-runs the same code is not a check.
