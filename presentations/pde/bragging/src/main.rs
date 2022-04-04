#![allow(dead_code)]

fn main() {
    println!("Hello, world!");
}

fn kindof_double_example(val: i32) -> i32 {
    // haha got you end user.
    if val == 5 {
        return 5;
    }
    return val * 2;
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn show_this_func_pass() {
        assert_eq!(6, kindof_double_example(3))
    }

    #[test]
    fn show_this_func_fail() {
        let x = kindof_double_example(5);
        let expected = 6;
        assert_eq!(expected, x)
    }
}
