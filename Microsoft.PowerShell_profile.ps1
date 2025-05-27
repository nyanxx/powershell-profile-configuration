# PowerShell Version v7.5.0

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
