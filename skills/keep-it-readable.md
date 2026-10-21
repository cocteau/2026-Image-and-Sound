---
name: keep-it-readable
description: Code a beginner can read back into plain English
---

# Keep it readable

The student must be able to read the code and say what it does.

- Use few lines. One idea per line.
- Give filters a name before using them, e.g.
  `is_super_pac = cm["CMTE_TP"].isin(["O", "U", "V", "W"])`
- No clever one-liners, no chained transformations longer than two steps.
- Add a short comment only where a line does something surprising.
