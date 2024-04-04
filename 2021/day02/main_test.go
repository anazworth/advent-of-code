package main

import (
	"os"
	"testing"
)

func TestPartOne(t *testing.T) {
	input, _ := os.ReadFile("example.txt")
	result := partOne(string(input))

	if result != 150 {
		t.Fatalf("Expected 1, got %d", result)
	}
}
