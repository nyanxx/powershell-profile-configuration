# PowerShell Version v7.5.0

Function Prompt {
	#$HomeDir = [Environment]::GetFolderPath("UserProfile")
	$CurrentDir = (Get-Location).Path
	$BatteryPercent = (Get-CimInstance Win32_Battery).EstimatedChargeRemaining

	if ($CurrentDir -eq "$HOME") {
		$CurrentDir = $CurrentDir -replace [Regex]::Escape($HOME), '~\'
	} elseif ($CurrentDir -like "$HOME*") {
		$CurrentDir = $CurrentDir -replace [Regex]::Escape($HOME), '~'
	}
	
	# Define ANSI color codes
	#$Green = "e[32m"
	#$Orange = "e[33m"
	#$Red = "e[31m"
	$RedWarning = "`e[31m⚠︎"
	$ResetColor = "`e[0m"

	if ($BatteryPercent -gt 50) {
		$ColoredMsg = "`e[32m[$BatteryPercent%]"
	} elseif ($BatteryPercent -gt 20) {
		$ColoredMsg = "`e[33m[$BatteryPercent%]"
	} elseif ($BatteryPercent -gt 10) {
		$ColoredMsg = "`e[31m[$BatteryPercent%]"
	} else {
		$ColoredMsg = "$RedWarning[$BatteryPercent%]"
	}
	
	#return "$ColoredMsg$ResetColor $CurrentDir>"
	return "$ColoredMsg$ResetColor $CurrentDir> "
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
