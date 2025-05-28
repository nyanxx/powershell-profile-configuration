# These functions depends on Sysinternals Disk Usage tool.

Function Get-CurrentDirectorySize {
	$dusize = (du -v | Select-String "Size:").ToString()
	# Size is shown in MB
	$sizeMB = [int]($dusize -replace '[^\d]', '') / 1MB
	"{0:N2} MB" -f $sizeMB
}

Function Get-DirectorySize {
	param([String]$pathofdir)
	# The paramater cannot be empty, if it is print gracefull message
	Write-Host "$pathofdir" -ForegroundColor Blue
	Write-Host "Comming Soon"
}

Function Get-FileSize {
	param([String]$pathtofile)
	# The paramater cannot be empty, if it is print gracefull message
	Write-Host "$pathtofile" -ForegroundColor Blue
	Write-Host "Comming Soon"
}

Set-Alias cdsize Get-CurrentDirectorySize
Set-Alias dsize Get-DirectorySize
Set-Alias fsize Get-FileSize


