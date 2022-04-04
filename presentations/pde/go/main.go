package main

import (
	"errors"
	"fmt"
)

func main() {
	fmt.Println("Hello", (func() int {
		// Overally complicated just to show treesitter :)
		ret, _, _, _ := (func() (int, error, string, int) {
			value := 0

			value, err := exampleFunction()
			if err != nil {
				return 0, err, "", 0
			}

			return value, errors.New("hello world"), "", 0
		})()

		return ret
	})(), "Another")
}

func exampleFunction() (int, error) {
	return 5, nil
}

func anotherFunction() int {
	x, _ := exampleFunction()
	return x
}
