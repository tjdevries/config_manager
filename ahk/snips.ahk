#SingleInstance force


TakeSnip() {
    Run SnippingTool.exe, , Max
    sleep, 300
    Send !n
    sleep, 30
    Send r
}


^+S::
    TakeSnip()
return
