# PS call stack based authentication (just for fun!)
Function getId($name) {
	# PowerShell CallStack Based Verification to Limit Function Access
	try {
		$ParentFileHash = <Generate-Hash-X> (Get-PSCallStack)[1].ScriptName.ToString()
		# Hash of the allowed path
		$AllowedFileHash = "<Some-Hash-Here>"
		if ($ParentFileHash -ne $AllowedFileHash) {
			throw
		}
	} catch {
		throw "Forbidden : You can't access this function!"
	}
	
	$AppId = Import-PowerShellDataFile -Path "$PROFILE_DIR\Functions\Chrome_Functions_IDs.psd1"
	#Write-Host $($MyInvocation.MyCommand.Path)
	return $AppId.$name
}
