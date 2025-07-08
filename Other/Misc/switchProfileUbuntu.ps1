param(
    [string]$profileName
)

# Open a new tab with the specified profile
wt -p $profileName

# Get the current terminal process id
$currentProcessId = $PID

# Sleep for a short duration to ensure the new tab opens
Start-Sleep -Milliseconds 500

# Close the current tab
Stop-Process -Id $currentProcessId
