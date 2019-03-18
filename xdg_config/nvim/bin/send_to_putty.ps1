# Source tricks
. "$PSScriptRoot\Tricks.ps1"

$putty = Get-Process | ? {$_.ProcessName -contains "putty"}

if ($putty) {
  # Send putty to foreground
  [void] [Tricks]::SetForegroundWindow($putty.MainWindowHandle)

  # TODO: Send the text to putty
} else {
  # TODO: Open a putty terminal using thunder or something?
}
