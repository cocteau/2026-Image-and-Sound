"""Small, tested checks. Each prints a clear PASS/FAIL line and returns True/False.

You don't need to read the insides. Read the description of each function,
and read (and add to) the tests in test_checks.py: they are hand-worked cases
that show what each check promises.
"""

from __future__ import annotations

__all__ = ["known_value", "in_range", "same_number", "show_rows"]


def _report(ok: bool, label: str, detail: str) -> bool:
    print(f"{'PASS' if ok else 'FAIL'}  {label}: {detail}")
    return ok


def known_value(actual, expected, label: str = "known value", tolerance: float = 0) -> bool:
    """Does our number match one we got from somewhere else (e.g. fec.gov)?

    tolerance is a fraction: 0.01 allows a 1% difference (useful because bulk
    files are snapshots and fec.gov keeps updating).
    """
    if isinstance(expected, (int, float)) and isinstance(actual, (int, float)):
        ok = abs(actual - expected) <= abs(expected) * tolerance
    else:
        ok = actual == expected
    return _report(ok, label, f"ours={actual!r}, source={expected!r}")


def in_range(value, low, high, label: str = "plausible range") -> bool:
    """Is the number inside the range we said, IN ADVANCE, would be believable?"""
    ok = low <= value <= high
    return _report(ok, label, f"{value!r} {'is' if ok else 'is NOT'} between {low!r} and {high!r}")


def same_number(a, b, label: str = "two routes agree") -> bool:
    """Did two different ways of computing the answer give the same result?"""
    return _report(a == b, label, f"{a!r} vs {b!r}")


def show_rows(df, mask, n: int = 5):
    """Show a few rows that were INCLUDED by a filter and a few that were EXCLUDED."""
    from IPython.display import display

    print(f"Included: {int(mask.sum()):,} rows (sample)")
    display(df[mask].head(n))
    print(f"Excluded: {int((~mask).sum()):,} rows (sample)")
    display(df[~mask].head(n))
