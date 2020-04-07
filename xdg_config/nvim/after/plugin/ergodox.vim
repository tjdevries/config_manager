" Goal:
"* Keymap 0: Basic layer
" *
" * ,--------------------------------------------------.           ,--------------------------------------------------.
" * |   =    |   1  |   2  |   3  |   4  |   5  | LEFT |           | RIGHT|   6  |   7  |   8  |   9  |   0  |   -    |
" * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
" * | Del    |   Q  |   W  |   E  |   R  |   T  |Insrt |           | Pse  |   Y  |   U  |   I  |   O  |   P  |   \    |
" * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
" * | Grv    |   A  |   S  |   D  |   F  |   G  |------|           |------|   H  | J/Alt|   K  |   L  |; / L2|   '    |
" * |--------+------+------+------+------+------| Hyper|           | Meh  |------+------+------+------+------+--------|
" * | LShift | Ctrl |   X  |   C  |   V  |   B  |      |           |      |   N  |   M  |   ,  |   .  |//Ctrl| ~L1    |
" * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
" *   |  Z   |  '"  |AltShf| Left | Right|                                       |  Up  | Down |   [  |   ]  | RShift |
" *   `----------------------------------'                                       `------------------------------------'
" *                                        ,-------------.       ,---------------.
" *                                        | App  | LGui |       | Alt  |Ctrl/Esc|
" *                                 ,------|------|------|       |------+--------+------.
" *                                 |      |      | Home |       | PgUp |        |      |
" *                                 | Space|Backsp|------|       |------|  Tab   |Enter |
" *                                 |      |ace   | End  |       | PgDn |        |      |
" *                                 `--------------------'       `----------------------'


let s:left_keys = 7
let s:right_keys = 7
let s:middle_spaces = 2

let s:reg_height = 4
let s:bottom = 1

let s:separator = '|'
let s:intersection = '+'
let s:corner = '.'

" Start constructing
let s:top_line = '/* Keymap '
let s:line_start = ' * '

" Make a line for the ergodox.
function! s:make_full_line(width, leftmost, left_corner, right_corner, rightmost) abort
    let result = s:line_start

    let result .= a:leftmost
    let result .= repeat('-', (s:left_keys * a:width) - 1) . a:left_corner
    let result .= repeat(' ', s:middle_spaces * a:width)
    let result .= a:right_corner . repeat('-', (s:right_keys * a:width) - 1)
    let result .= a:rightmost . "\n"

    return result
endfunction

" Make an ergodox keyboard layout
function! s:make_ergodox_layout(width) abort
    let bottom_line = ' */'

    let result = s:top_line . "\n" . s:line_start . "\n"

    let cell = s:separator . repeat(' ', a:width - 1)

    let key_row = 0
    while key_row < (s:reg_height * 2)
        if fmod(key_row, 2) == 1
            " Left side of the keyboard
            let result .= s:line_start . repeat(cell, s:left_keys) . s:separator 
            " Center of the keyboard
            let result .= repeat(' ', s:middle_spaces * a:width)
            " Right side of the keyboard
            let result .= repeat(cell, s:right_keys) . s:separator
            " New line
            let result .= "\n"
        else
            if key_row == 0
                let leftmost = s:corner
                let left_corner = s:corner
                let right_corner = s:corner
                let rightmost = s:corner
            else
                let leftmost = s:separator
                let left_corner = s:separator
                let right_corner = s:separator
                let rightmost = s:separator
            endif

            let result .= s:make_full_line(a:width, leftmost, left_corner, right_corner, rightmost)

        endif

        let key_row = key_row + 1
    endwhile

    let result .= s:make_full_line(a:width, "'", "'", "'", "'")

    return result
endfunction

" echo s:make_ergodox_layout(6)
" echo s:make_ergodox_layout(7)
