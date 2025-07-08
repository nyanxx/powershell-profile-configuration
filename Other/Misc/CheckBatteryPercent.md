# This is slow

```powershell
(Get-WmiObject win32_battery).estimatedChargeRemaining
```


# This is fast

```powershell
(Get-CimInstance Win32_Battery).EstimatedChargeRemaining
```

## Don't know the reason
