from rucksack import Rucksack

EXAMPLE = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

def test_sum_priorities():
    rucksack = Rucksack(EXAMPLE)
    result = rucksack.sum_priorities()
    assert result == 157

def test_part_two():
    rucksack = Rucksack(EXAMPLE)
    result = rucksack.sum_badge_type()
    assert result == 70
