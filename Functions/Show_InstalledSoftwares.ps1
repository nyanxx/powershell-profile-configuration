# Fix: There are still some applications not getting listed
Function List-InstalledSoftwares {
	param([System.String]$arg)

	$listApps = @( Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue
	Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue )

	if ($arg -eq $null) {
		$listApps | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize
	}
	else {
		#$listApps | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize | findstr.exe $arg
		$listApps | Where-Object { $_.DisplayName -match $arg } | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize
	}
}
Set-Alias softlist List-InstalledSoftwares
