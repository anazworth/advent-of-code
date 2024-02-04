import cleanup

with open('input.txt', 'r') as f:
    input = f.read()

c = cleanup.Cleanup(input)

print("Part 1:", c.total_pairs_contained()[0])
print("Part 2:", c.total_pairs_contained()[1])
