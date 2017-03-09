#SingleInstance force


IsMSWindow(title) {
    WinGetClass, class, %title%,

    if (class = "OpusApp") {
        return true
    }

    return false
}
