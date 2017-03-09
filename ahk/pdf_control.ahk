#SingleInstance force


MoveDown() {
    ; Alt-tab
    Send !{Tab}
    sleep, 100

    ; down
    Send {Down}
    sleep, 30

    ; Alt-tab
    Send !{Tab}
    sleep, 100

}

MoveUp() {
    ; Alt-tab
    Send !{Tab}
    sleep, 100

    ; down
    Send {Up}
    sleep, 30

    ; Alt-tab
    Send !{Tab}
    sleep, 100

}


^+J::
    MoveDown()
return

^+K::
    MoveUp()
return

