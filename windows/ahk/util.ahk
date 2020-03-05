#SingleInstance force

GetMonitor(hwnd := 0) {
    ; If no hwnd is provided, use the Active Window
    if (hwnd)
    {
        WinGetPos, winX, winY, winW, winH, ahk_id %hwnd%
    }
    else
    {
        WinGetActiveStats, winTitle, winW, winH, winX, winY
    }

    SysGet, numDisplays, MonitorCount
    SysGet, idxPrimary, MonitorPrimary
    Loop %numDisplays%
    {
        SysGet, mon, MonitorWorkArea, %a_index%
        leftShift := 0
        rightShift := 0
        ; Left may be skewed on Monitors past 1
        if (a_index > 1)
        {
            leftShift := 20
        }
        ; Right overlaps Left on Monitors past 1
        else if (numDisplays > 1)
        {
            rightShift := 20
        }
        ; Tracked based on X. Cannot properly sense on Windows "between" monitors
        xMin := monLeft - leftShift
        xMax := monRight - rightShift
        if (winX >= xMin AND (winX + winW / 2) <= xMax)
        {
            return %a_index%
        }
    }
    ; Return Primary Monitor if can't sense
    return idxPrimary
}

global pdf_window_id := -1


IsMSWindow(title) {
    WinGetClass, class, %title%,

    if (class = "OpusApp") {
        return true
    }

    return false
}

IsPDFClass(active_class) {
    if (active_class == "AcrobatSDIWindow") {
        return true
    }

    return false
}


FindPDFWindow() {
    ; TODO: Make a way to reset the pdf_window_id without restarting
    ; and find a good key to bind it to.

    global pdf_window_id

    ; Check if the window is still valid
    IfWinNotExist, ahk_id %pdf_window_id%
    {
        pdf_window_id = -1
    }

    ; If we don't have a valid window,
    ; then we better find it!
    if (pdf_window_id == -1) {
        ; First check if our active window is good.
        ; This way we choose the active pdf if more than one are open
        WinGetClass, active_class, A

        if (IsPDFClass(active_class)) {
            WinGet, pdf_window_id, ID, ahk_class %active_class%
        }

        ; If we didn't find it in the last try,
        ; loop through the available windows and pick one
        if (pdf_window_id == -1) {
            WinGet, id, list,,, Program Manager
            Loop, %id%
            {
                this_id := id%A_Index%

                WinGetClass, active_class, ahk_id %this_id%
                if (IsPDFClass(active_class)) {
                    WinGet, pdf_window_id, ID, ahk_class %active_class%
                }
            }
        }
    }

    return pdf_window_id
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
