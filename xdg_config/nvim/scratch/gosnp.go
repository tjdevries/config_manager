package main

func main() {}

type MyStruct struct {
	name string
}

func getSomeValue(val string) (MyStruct, error, error) {
}

func AnotherExample() (*MyStruct, error, int, bool) {
	myVal, err := getSomeValue("wow")
	if err != nil {
		return nil, err, 0, false
	}

	return &myVal, nil, 0, true
}
