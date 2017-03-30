#SingleInstance force

#include %A_ScriptDir%\util.ahk

global default_numerator := 2
global default_denominator := 3

VerticalSplit(direction,numerator,denominator,error) {
    ; direction: 0 for up, 1 for down
    ; numerator: The numerator of the fraction of the screen to take up
    ; denominator: The denominator of the fraction of the screen to take up
    ; error: Some fudge value to make it actually get to the edges of the screenes.
    ;
    ; Example: VerticalSplit(0,1,2,7) -> Split the top half of the screen with an error of 7 pixels
    WinGetPos, X, Y, W, H, A
    WinGetTitle, Title, A

    ; MsgBox, A is "%Title%".
    ms_window := IsMSWindow(Title)

    MonitorNumber := GetMonitor()

    ; At one point I used monitor work area for this, but I don't think it's required.
    ; SysGet, Mon, MonitorWorkArea, %MonitorNumber%

    SysGet, Mon, MonitorWorkArea, %MonitorNumber%

    ; Optional debug info
    ; MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom%. %X% %Y% %W% %H% %A%

    ; Calculate important size items
    height := abs(MonTop - MonBottom) * numerator / denominator
    top := (1 - direction) * MonTop + direction * (MonBottom - height)

    ; Get the class of Window
    if (ms_window)
    {
        width := abs(MonRight - MonLeft)
        left := MonLeft
    }
    else
    {
        width := abs(MonRight - MonLeft) + (error * 1)
        left := MonLeft - error
    }
    WinMove,A,,left,top,width,height

    return
}


; Move window up (Windows + Shift + UP)
+#Up::
    global default_numerator, default_denominator

    VerticalSplit(0,default_numerator,default_denominator,7)
return

; Move window down (Windows + Shift + DOWN)
+#Down::
    global default_numerator, default_denominator

    VerticalSplit(1,1,default_denominator,7)
return

+#Left::
    global default_numerator, default_denominator
    EnvAdd, default_numerator, -1
    EnvAdd, default_denominator, -1
return

+#Right::
    global default_numerator, default_denominator
    EnvAdd, default_numerator, 1
    EnvAdd, default_denominator, 1
return

