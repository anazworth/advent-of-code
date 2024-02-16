export function sumVisibleTrees(input: string): number {
  const dir = {
    up: [-1, 0],
    down: [1, 0],
    left: [0, -1],
    right: [0, 1],
  };

  const map = input
    .trim()
    .split("\n")
    .map((row) => row.split(""))
    .map((row) => row.map(Number));

  let visible = 0;
  for (let row = 0; row < map.length; row++) {
    for (let col = 0; col < map[row].length; col++) {
      const currentNumber = map[row][col];
      let found = false;
      for (let [y, x] of Object.values(dir)) {
        const dirY = y;
        const dirX = x;
        while (!found) {
          const currentY = row + y;
          const currentX = col + x;
          if (
            currentY < 0 ||
            currentX < 0 ||
            currentY >= map.length ||
            currentX >= map[currentY].length
          ) {
            visible++;
            found = true;
            break;
          }
          const nextNumber = map[currentY][currentX];
          if (nextNumber >= currentNumber) {
            break;
          }
          y += dirY;
          x += dirX;
        }
      }
    }
  }
  return visible;
}

export function bestTree(input: string): number {
  const dir = {
    up: [-1, 0],
    left: [0, -1],
    right: [0, 1],
    down: [1, 0],
  };

  const map = input
    .trim()
    .split("\n")
    .map((row) => row.split(""))
    .map((row) => row.map(Number));

  let best = 0;
  for (let row = 0; row < map.length; row++) {
    for (let col = 0; col < map[row].length; col++) {
      const currentNumber = map[row][col];
      const viewScore = [];

      for (let [y, x] of Object.values(dir)) {
        let currentScore = 0;
        let stop = false;
        const dirY = y;
        const dirX = x;
        while (!stop) {
          const currentY = row + y;
          const currentX = col + x;
          if (
            currentY < 0 ||
            currentX < 0 ||
            currentY >= map.length ||
            currentX >= map[currentY].length
          ) {
            viewScore.push(currentScore);
            stop = true;
            break;
          }
          const nextNumber = map[currentY][currentX];
          if (nextNumber >= currentNumber) {
            currentScore++;
            viewScore.push(currentScore);
            stop = true;
            break;
          }
          y += dirY;
          x += dirX;
          currentScore++;
        }
      }
      const score = viewScore.reduce((a, b) => a * b);
      best = Math.max(best, score);
    }
  }
  return best;
}
// Learn more at https://deno.land/manual/examples/module_metadata#concepts
if (import.meta.main) {
  console.log(
    "Part One: ",
    sumVisibleTrees(Deno.readTextFileSync("input.txt"))
  );
  console.log("Part Two: ", bestTree(Deno.readTextFileSync("input.txt")));
}
