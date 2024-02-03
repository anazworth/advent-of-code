from rucksack import Rucksack

with open('input.txt', 'r') as f:
    input = f.read()

rucksack = Rucksack(input)

print("Part 1:", rucksack.sum_priorities())
print("Part 2:", rucksack.sum_badge_type())
