import { assertEquals } from "https://deno.land/std@0.214.0/assert/mod.ts";
import { sumVisibleTrees, bestTree } from "./main.ts";

Deno.test("Part One", async function sumVisibleTreesTest() {
  const input = await Deno.readTextFile("example.txt");
  assertEquals(sumVisibleTrees(input), 21);
});

Deno.test("Part Two", async function bestTreeTest() {
  const input = await Deno.readTextFile("example.txt");
  assertEquals(bestTree(input), 8);
});
