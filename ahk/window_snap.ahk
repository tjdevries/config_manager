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
        if (winX >= xMin AND winX <= xMax)
        {
            return %a_index%
        }
    }
    ; Return Primary Monitor if can't sense
    return idxPrimary
}


; Move window up (Windows + Shift + UP ... NOTE must maximize window first)
+#Up::
    WinGetPos,X,Y,W,H,A,,,
    WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

    MonitorNumber := GetMonitor()
    SysGet, Mon, MonitorWorkArea, %MonitorNumber%
    ; MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom%. %X% %Y% %W% %H% %A%

    ; Calculate important size items
    error := 7
    height := abs(MonTop - MonBottom)/2
    width := abs(MonRight - MonLeft) + error * 2
    WinMove,A,,MonLeft-error,MonTop,width,height
return

; Move window down (Windows + Shift + DOWN ... NOTE must maximize window first)
+#Down::
    WinGetPos,X,Y,W,H,A,,,
    WinMaximize
    WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

    MonitorNumber := GetMonitor()
    SysGet, Mon, MonitorWorkArea, %MonitorNumber%
    ; MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom%. %X% %Y% %W% %H% %A%

    ; Calculate important size items
    error := 7
    height := abs(MonTop - MonBottom)/2
    width := abs(MonRight - MonLeft) + error * 2
    WinMove,A,,MonLeft-error,MonTop+height,width,height
return
