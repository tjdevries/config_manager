package introduction

// Show example of much more complicated expansion
func MyFunc(x, y string) (string, bool, error) {
	var combined string

	combined, err := OtherFunc(x, y)
	if err != nil {
		return "", false, errors.Wrap(err, "OtherFunc")
	}

	combined, err := OtherFunc(x, y)
	if err != nil {
		return "", false, err
	}


	return combined, true, nil
}

// Silly function that doesn't do anything useful
func OtherFunc(x, y string) (string, error) {
	return x + y, nil
}
