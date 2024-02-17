import { assertEquals } from "https://deno.land/std@0.214.0/assert/mod.ts";
import { partOne, partTwo } from "./main.ts";

const EXAMPLE = await Deno.readTextFile("example.txt");

Deno.test("Part One", () => {
  assertEquals(partOne(EXAMPLE), 7);
});

Deno.test("Part Two", () => {
  assertEquals(partTwo(EXAMPLE), 5);
});
