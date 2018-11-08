#
# Open a link in the browser and bring to focus!
#

. "$PSScriptRoot\Tricks.ps1"

# Set BrowserNavConstants to open URL in new tab
# Full list of BrowserNavConstants: https://msdn.microsoft.com/en-us/library/aa768360.aspx
$navOpenInNewTab = 0x800

# Get running Internet Explorer instances
$App = New-Object -ComObject shell.application

# Grab the last opened tab
$IE = $App.Windows() | where {$_.name -eq "Internet Explorer" } | select -First 1

# TODO: Make this better at opening
If ($IE.HWND -gt 0) {
} else {
  Invoke-Item "C:\Program Files\Internet Explorer\iexplore.exe"
  $App = New-Object -ComObject shell.application
  $IE = $App.Windows() | where {$_.name -eq "Internet Explorer" } | select -First 1A
}

# Open link in the new tab nearby
$IE.navigate($args[0], $navOpenInNewTab)

# TODO: Seems like this still goes to foreground every time, and I can't figure out why.
if ($args[0] -eq "1") {
  [void] [Tricks]::SetForegroundWindow($IE.HWND)
}

# Cleanup
# This gave me errors, so I commented it out!
# 'App', 'IE' | ForEach-Object {Remove-Variable $_ -Force}
