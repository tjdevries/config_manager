#include %A_ScriptDir%\window_snap.ahk
#include %A_ScriptDir%\pdf_control.ahk
#include %A_ScriptDir%\snips.ahk
#include %A_ScriptDir%\abbr.ahk
#include %A_ScriptDir%\AutoCorrect.ahk

^!r::Reload  ; Assign Ctrl+Alt+r as a hotkey to restart the script

; My own abbreviations
::Visists::Visits
::1o1::1-on-1


^!E::
    Run cmd.exe /c %clipboard%
return
