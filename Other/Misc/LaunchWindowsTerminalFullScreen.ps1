Start-Process "wt.exe" -ArgumentList "-p Ubuntu"

Start-Sleep -Seconds 2

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class SendKeys {
   [DllImport("user32.dll", CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
   public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, uint dwExtraInfo);
   private const int KEYEVENTF_KEYUP = 0x2;
   public static void SendF11() {
       keybd_event(0x7A, 0, 0, 0); // F11 key down
       keybd_event(0x7A, 0, KEYEVENTF_KEYUP, 0); // F11 key up
   }
}
"@
[SendKeys]::SendF11()
