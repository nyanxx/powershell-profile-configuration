# PowerShell Version v7.5.0

Function Prompt {
	$CurrentDir = Get-Location
	$BatteryPercent = (Get-CimInstance Win32_Battery).EstimatedChargeRemaining

	# Define ANSI color codes
	$Green = "`e[32m"
	$Orange = "`e[33m"
	$Red = "`e[31m"
	$Warning = "`e[31m⚠"
	$ResetColor = "`e[0m"

	if ($BatteryPercent -gt 50) {
		$ColoredMsg = "$Green[$BatteryPercent%]"
	} elseif ($BatteryPercent -gt 20) {
		$ColoredMsg = "$Orange[$BatteryPercent%]"
	} elseif ($BatteryPercent -gt 10) {
		$ColoredMsg = "$Red[$BatteryPercent%]"
	} else {
		$ColoredMsg = "$Warning[$BatteryPercent%]"
	}

	return "$ColoredMsg $ResetColor PS $CurrentDir> "
}


# To Turn Off PowerShell Update Check 
# Create an Environmental Variable "POWERSHELL_UPDATECHECK" and "Off" as Its Value.

# Turn Off Predictive IntelliSense Ghosted Suggestions
Set-PSReadLineOption -PredictionSource None

# Other Variables
$ONEDRIVE_DIR = "$HOME\OneDrive"
# Setting Profile Directory Variable
$PROFILE_DIR = [System.IO.Path]::GetDirectoryName($PROFILE)

# Source Aliases
if (Test-Path "$PROFILE_DIR\Aliases\profile_aliases.ps1") { . "$PROFILE_DIR\Aliases\profile_aliases.ps1" }
# Source Functions
if (Test-Path "$PROFILE_DIR\Functions\init.ps1") { . "$PROFILE_DIR\Functions\init.ps1" }
