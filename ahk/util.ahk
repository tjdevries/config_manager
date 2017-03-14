#SingleInstance force


IsMSWindow(title) {
    WinGetClass, class, %title%,

    if (class = "OpusApp") {
        return true
    }

    return false
}

; GetOneNoteID() {
    ; See if we can find a window that is a OneNote Window
    ; We will return the ID of this window
    ; WinGet, onenote_id, ProcessName, , ahk_class  ONENOTE,

    ; MsgBox, ID is "%onenote_id%"

    ; if (%onenote_id%) {
        ; MsgBox, Found ID
    ; } else {
        ; MsgBox, No Id again
    ; }

    ; return
; }

; GetOneNoteID()
; return
