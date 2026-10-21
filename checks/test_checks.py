"""Hand-worked cases. Run with:  pytest checks

Each test is a tiny example where we already know the right answer.
Add your own whenever you add or change a check.
"""

from checks import known_value, in_range, same_number


def test_known_value_exact():
    assert known_value(450, 450)
    assert not known_value(450, 451)


def test_known_value_tolerance():
    # 1% of 1,000 is 10, so 1,009 passes and 1,011 fails
    assert known_value(1009, 1000, tolerance=0.01)
    assert not known_value(1011, 1000, tolerance=0.01)


def test_known_value_text():
    assert known_value("O", "O")


def test_in_range():
    assert in_range(5, 1, 10)
    assert not in_range(50, 1, 10)


def test_same_number():
    assert same_number(3, 3)
    assert not same_number(3, 4)
