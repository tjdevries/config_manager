; Determine what type of window I'm in to paste this smarter

if WinActive("ahk_class PuTTY")
{
    Send +{Insert}
}
else
{
    Send ^v
}
