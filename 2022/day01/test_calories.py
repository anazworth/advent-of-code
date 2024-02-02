from calories import Calories

EXAMPLE = r"""1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""

def test_init():
    c = Calories(100)
    assert c.input == 100

def test_calculate_part_one():
    c = Calories(EXAMPLE)
    result, _ = c.calculate()

    assert result == 24000

def test_calculate_part_two():
    c = Calories(EXAMPLE)
    _, result = c.calculate()

    assert result == 45000
