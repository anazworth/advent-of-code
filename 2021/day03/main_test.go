package main

import (
	"os"
	"testing"
)

func TestPartOne(t *testing.T) {
	data, err := os.ReadFile("example.txt")
	check(err)
	if partOne(data) != 198 {
		t.Fail()
	}
}

func TestPartTwo(t *testing.T) {
	data, err := os.ReadFile("example.txt")
	check(err)
	if partTwo(data) != 230 {
		t.Fail()
	}
}
