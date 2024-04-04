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
