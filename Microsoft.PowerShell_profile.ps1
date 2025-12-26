# PowerShell Version v7.5.0

Function Prompt {
	$PROMPT_ALTERNATIVE = 'twoline'
	$NEWLINE_BEFORE_PROMPT = 'yes'
	
	$CurrentDir = (Get-Location).Path
	$BatteryPercent = (Get-CimInstance Win32_Battery).EstimatedChargeRemaining

	if ($CurrentDir -eq "$HOME") {
		$CurrentDir = $CurrentDir -replace [Regex]::Escape($HOME), '~\'
	}
	elseif ($CurrentDir -like "$HOME*") {
		$CurrentDir = $CurrentDir -replace [Regex]::Escape($HOME), '~'
	}

	if ($BatteryPercent -gt 50) {
		$ColoredMsg = "`e[32m[$BatteryPercent%]"
	}
	elseif ($BatteryPercent -gt 20) {
		$ColoredMsg = "`e[33m[$BatteryPercent%]"
	}
	elseif ($BatteryPercent -gt 10) {
		$ColoredMsg = "`e[31m[$BatteryPercent%]"
	}
	else {
		$ColoredMsg = "`e[31m⚠️[$BatteryPercent%]"
	}

	$esc = [char]27
	$bold = "$esc[1m"
	$reset = "$esc[0m"
	if ($NEWLINE_BEFORE_PROMPT -eq 'yes') { Write-Host }
	if ($PROMPT_ALTERNATIVE -eq 'twoline') {
		Write-Host "┌──(" -NoNewLine -ForegroundColor Blue
		Write-Host "${bold}$([environment]::username)@$([system.environment]::MachineName)${reset}" -NoNewLine -ForegroundColor Magenta
		Write-Host ")-[" -NoNewLine -ForegroundColor Blue
		Write-Host "${bold}${CurrentDir}${reset}" -NoNewLine -ForegroundColor White
		Write-Host "]" -ForegroundColor Blue
		Write-Host "└─" -NoNewLine -ForegroundColor Blue
		Write-Host "${bold}${ColoredMsg}${reset}" -NoNewline
		Write-Host "${bold}>${reset}" -NoNewLine -ForegroundColor Blue
	}
	else {
		# Battery percentage indicator not added here 
		Write-Host "${bold}PS " -NoNewLine -ForegroundColor Blue
		Write-Host "$([environment]::username)@$([system.environment]::MachineName) " -NoNewLine -ForegroundColor Magenta
		Write-Host "${CurrentDir}>${reset}" -NoNewLine -ForegroundColor Blue
	}

	return " "
}

# To Turn Off PowerShell Update Check 
# Open EditEnvironmentVariables in PowerShell Using : "rundll32.exe sysdm.cpl,EditEnvironmentVariables"
# Create an Environment Variable "POWERSHELL_UPDATECHECK" and "Off" as Its Value.

# To Turn Off Predictive IntelliSense Ghosted Suggestions
Set-PSReadLineOption -PredictionSource None # [None, Plugin, History (default)]
#Set-PSReadLineOption -PredictionSource Plugin

# Other Variables
# $ONEDRIVE_DIR = "$HOME\OneDrive"
$PROFILE_DIR = [System.IO.Path]::GetDirectoryName($PROFILE) # Setting Profile Directory Variable
# $HomeDir = [Environment]::GetFolderPath("UserProfile")


# Source Aliases
if (Test-Path "$PROFILE_DIR\Aliases\profile_aliases.ps1") { . "$PROFILE_DIR\Aliases\profile_aliases.ps1" }
# Source Functions
if (Test-Path "$PROFILE_DIR\Functions\init.ps1") { . "$PROFILE_DIR\Functions\init.ps1" }

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Make fzf use fd 
# 1. Set-PsFzfOption -EnableFd:$true (requires some Module)
# 2. OR set the Environment Variable : [System.Environment]::SetEnvironmentVariable('FZF_DEFAULT_COMMAND', 'fd --type f', 'User')
# 
# # Check the Variable using `Get-ChildItem Env:FZF_DEFAULT_COMMAND` OR `$env:FZF_DEFAULT_COMMAND`
#
# 3. Set fd temporarily
# 	- $env:FZF_DEFAULT_COMMAND = 'fd --type f'
