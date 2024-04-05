package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func check(err error) {
	if err != nil {
		fmt.Println(err)
	}
}

func main() {
	data, err := os.ReadFile("input.txt")
	check(err)

	fmt.Println("Part one:", partOne(data))
	fmt.Println("Part one:", partTwo(data))
}

func partOne(data []byte) int64 {

	lineLength := strings.Index(string(data), "\n")
	arr := make([]int, lineLength)

	lines := strings.Split(string(data), "\n")

	for _, line := range lines {
		for i, char := range line {
			if char == '1' {
				arr[i]++
			} else {
				arr[i]--
			}
		}
	}

	var gamma string
	var epsilon string
	for _, val := range arr {
		if val > 0 {
			gamma += "1"
			epsilon += "0"
		} else {
			gamma += "0"
			epsilon += "1"
		}
	}
	g, _ := strconv.ParseInt(gamma, 2, 64)
	e, _ := strconv.ParseInt(epsilon, 2, 64)
	return g * e
}

func partTwo(data []byte) int64 {

	lines := strings.Split(string(data), "\n")
	for i, line := range lines {
		if line == "" {
			lines = append(lines[:i], lines[i+1:]...)
		}
	}
	oxygen := partTwoParser(lines, "1", "0")
	co2 := partTwoParser(lines, "0", "1")
	val1, _ := strconv.ParseInt(oxygen, 2, 64)
	val2, _ := strconv.ParseInt(co2, 2, 64)
	return val1 * val2
}

func partTwoParser(lines []string, bitOne string, bitTwo string) string {
	lineLength := len(lines[0])

	arr := lines
	for i := range lineLength {
		if len(arr) == 1 {
			break
		}
		m := make(map[int]int)
		m[i] = 0

		current := make([]string, 0)
		for _, line := range arr {
			if line[i] == '1' {
				m[i]++
			} else {
				m[i]--
			}
		}
		var val any
		if m[i] >= 0 {
			val = bitOne
		} else {
			val = bitTwo
		}
		for _, line := range arr {
			if string(line[i]) == val {
				current = append(current, line)
			}
		}
		arr = current
	}
	return arr[0]
}
