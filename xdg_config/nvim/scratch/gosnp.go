package main

func main() error {
	return nil
}

type MyStruct interface{}

func AnotherExample() (*MyStruct, error, bool) {
	val, err := f()
	if err != nil {
		return nil, errors.Wrap(err, "f"), false
	}
	val, err := f()
	if err != nil {
		return nil, errors.Wrap(err, "f"), false
	}

}
