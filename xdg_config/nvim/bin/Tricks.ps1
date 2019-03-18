

# Thanks:
# http://stackoverflow.com/questions/2556872/how-to-set-foreground-window-from-powershell-event-subscriber-action
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Tricks {
     [DllImport("user32.dll")]
     [return: MarshalAs(UnmanagedType.Bool)]
     public static extern bool SetForegroundWindow(IntPtr hWnd);
  }
"@
