#SingleInstance force

PDFMove(direction) {
    ; Get the current id
    WinGet, current_id, ID, A

    ; Get the pdf id
    pdf_id := FindPDFWindow()
    WinActivate, ahk_id %pdf_id%

    ; move direction
    if (direction == "down") {
        Send {PgDn}
    }

    if (direction == "up") {
        Send {PgUp}
    }

    ; Register the keypress, then go back
    ; Surely you can wait 10 ms
    sleep, 10

    ; Go back
    WinActivate, ahk_id %current_id%
}


PDFMoveDown() {
    PDFMove("down")
}

PDFMoveUp() {
    PDFMove("up")
}


^+J::
    PDFMoveDown()
return

^+K::
    PDFMoveUp()
return

