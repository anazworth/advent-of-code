import crane

with open("input.txt") as f:
    input = f.read()

print("Part 1:", crane.Crane(input).top_crate())
print("Part 2:", crane.Crane(input).top_crate_2())
