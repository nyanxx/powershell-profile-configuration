# NOTE: This function is unnecessary now, as the issue was related to older PowerShell versions like v1. However, the latest PowerShell versions includes this by default.

# Function for cd / Set-Location to make it act like it does in Linux
# TODO: Add a feature of "cd -" to go on previous dir
Remove-Item Alias:cd -ErrorAction SilentlyContinue
#Remove-Item Alias:cd
#$ErrorActionPreference = "stop" # REF:https://stackoverflow.com/questions/73262899/powershell-does-not-catch-set-location-error
Function Set-LocationRemake {
	Try {
		#Get-Content -Path "C:fake_pathfake_file.txt" -ErrorAction Stop # Throws a ItemNotFoundException
       		#fakeFunction # Throw a RuntimeException
        	#$divideZero = 1/0 # Divide by zero to throw an exception that won't be specifically caught

		if ($args.Count -eq 0) {
                	Set-Location $HOME
        	} else {
                	Set-Location ($args -join ' ') -ErrorAction Stop  # Convert array to a string
        	}

	} Catch {
		#Write-Host "General exception caught: $($_.Exception.Message)"
		Write-Host "Directory $($args -join ' ') not found in $PWD"  -ForegroundColor Red
	}
}
# REF: https://www.ninjaone.com/blog/powershell-error-handling-guide/
Set-Alias cd Set-LocationRemake
