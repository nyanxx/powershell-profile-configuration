# Source Function Files
# Define an array of function files-name
$functionFiles = @(
	"WSL_Functions.ps1",			# Source Functions For WSL
	"Chrome_Functions.ps1",			# Source Functions For Chrome & ChromeApps
	#"cdRemake_Function.ps1",		# NOTE! The newer version of PowerShell has fixed most issues, except for navigating back to a previous location with special characters in the directory path, such as: '[ 10 ] Example
	#"tempc_fun.ps1",			# Source Function For Temperature ( Require Administrative Privileges )
	"TrashCLI_Function.ps1",		# Source Function Of Trash-Cli ( Windows Remake )
	"lsRemake_Function.ps1",		# Get-ChildItem-Remake & Original ls -> la
	"Syncthing_Interact.ps1",
	"Get-Size.ps1",
	"Show_InstalledSoftwares.ps1",
	"WifiMan.ps1"
)

# Loop through each function file and source it if it exists
foreach ($file in $functionFiles) {
    $filePath = "$PROFILE_DIR\Functions\$file"
    if (Test-Path $filePath) {
	    . $filePath
    }
    else {
	    #Write-Error "$file not found!"
	    Write-Host "Functions : $file not found!" -ForegroundColor Red
	}
}
