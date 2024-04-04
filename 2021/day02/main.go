package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func main() {
	input, err := os.ReadFile("input.txt")
	check(err)

	fmt.Println("Part 1: ", partOne(string(input)))
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func partOne(input string) int {
	ins := strings.Split(input, "\n")

	x, y := 0, 0

	for _, d := range ins {
		if d == "" {
			continue
		}
		direction := strings.Split(d, " ")
		dir, val := direction[0], direction[1]

		switch dir {
		case "forward":
			val, err := strconv.Atoi(val)
			check(err)
			x += val
		case "up":
			val, err := strconv.Atoi(val)
			check(err)
			y += val
		case "down":
			val, err := strconv.Atoi(val)
			check(err)
			y -= val
		}
	}
	return x * int(math.Abs(float64(y)))
}
