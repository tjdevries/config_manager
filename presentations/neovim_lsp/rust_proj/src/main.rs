/*
Define your own behavior!

nnoremap <Leader>tt :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }<CR>

Or run on save!
 */

struct Person<'a> {
    // The 'a defines a lifetime
    name: &'a str,
    age: u8,
}

fn main() {
    (0..10)
        .map(|n| n * 2) 
        .for_each(|n| println!("{}", n));


    let a = 2;
    let b = a + 3;
    println!("{} {}", a, b);
    println!("wow {} {}", b, a);

    let c = "hello world!";

    let name = "TJ";
    let age = 26;
    let teej = Person { name, age };

    println!("{} {}", c, teej);
}
