package main

func main() {}

type MyStruct struct {
	name string
}

func getSomeValue(val string) (MyStruct, error) {
	return MyStruct{name: val}, nil
}

func AnotherExample() (*MyStruct, error, int, bool) {
	var myVal MyStruct

	return &myVal, nil, 0, true
}
