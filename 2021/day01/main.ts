export function partOne(input: string): number {
  const depths = input
    .split("\n")
    .filter((line) => line !== "")
    .map(Number);

  let increases = 0;
  for (let i = 1; i < depths.length; i++) {
    if (depths[i] > depths[i - 1]) {
      increases += 1;
    }
  }
  return increases;
}

export function partTwo(input: string): number {
  const depths = input
    .split("\n")
    .filter((line) => line !== "")
    .map(Number);

  let increase = 0;
  for (let i = 3; i < depths.length; i++) {
    const windowA = depths.slice(i - 3, i).reduce((a, b) => a + b, 0);
    const windowB = depths.slice(i - 2, i + 1).reduce((a, b) => a + b, 0);

    if (windowB > windowA) {
      increase += 1;
    }
  }
  return increase;
}

// Learn more at https://deno.land/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const input = await Deno.readTextFile("input.txt");
  console.log("Part One: " + partOne(input));
  console.log("Part Two: " + partTwo(input));
}
