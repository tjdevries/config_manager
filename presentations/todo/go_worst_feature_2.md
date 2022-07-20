
# Clarifications

- Don't think they should remove the feature in Go 1
  - However, there is talk of removing it for Go 2 (which is a thing?)
    https://github.com/golang/go/issues/21291

    SO IM DEFINITELY NOT CRAZY

  - I just wanted to make tons of Go puns
    - please rewatch the video if you didn't notice them. That means my delivery was perfect dad tier

  - I was just saying that the feature *should not have been made* not that it should be deleted. Those
  are two very different things when you're talking about an existing language, feature, product, etc.

- Named Return vs. Naked Return
  - Named Return Values
    - So let's start with making it clear that I'm not opposed to this feature in general.
    - I think it's nice that you can "self-document" the code with naming the return values
    and that can show up in documentation

    - If naked returns did not exist, I would liked named returns better!

    - However, just because I like the feature doesn't mean that I'm confident in its worthiness of existing in Go.
      - is it really so much better than typing `var x, y int` at the top of your function?
      - They don't behave like other variables. Someone mentioned in the comments that they are initialized
      and returned, but I actually gave an example where they were never used and still didn't generate
      a warning or compiler error (which I think they should, to be consistent).
        - But in that case, it's probably super annoying to use and if you want to ignore some parameters,
        that doesn't work out super great.

  - Naked Return
    - I think I found out something even MORE horrible... defer functions

```go
func ReturnId() (id int, err error) {
   defer func() {
      if id == 10 {
         err = fmt.Errorf("Invalid Id\n")
      }
   }()

   id = 10

   return
}

func ReturnId2() (id int, err error) {
   defer func(id int) {
      if id == 10 {
         err = fmt.Errorf("Invalid Id\n")
      }
   }(id)

   id = 10

   return
}

// RETURNS 2 ???
// As one would expect. The deferred code runs after the normal code in the
// function has ended, and before the calling code has resumed. Named return
// values are in scope and can be read and modified.
 func c() (i int) {
    defer func() { i++ }()
    return 1
}

// RETURNS ERROR????
func test() (res int, err error) {
	res = 5
	defer func() { err = fmt.Errorf("error in defer") }() 
	return res, nil
}



// makes sense when you see it here but there's no way most people know this

package main

// Emonstrate that defered functions can chnage the return value
// and one cannot simulate that with local variables.

import (
	"fmt"
)

func incrementer(i *int) {
	*i++
}

func test1() (i int) {
	defer incrementer(&i)

	// Go copies 1 into the location named by "i" and then
	// calls defered functions.
	return 1
}

func test2() int {
	i := 0
	defer incrementer(&i)

	// The value named by "i" is copied first into the
	// return location and then the defered code is called.
	// Thus changes to i have no effect on the return value.
	return i
}

func main() {
	fmt.Println("named result:", test1())
	fmt.Println("local variable:", test2())
}
```
