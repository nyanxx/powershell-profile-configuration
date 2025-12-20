# chrome://apps

# SCOPE: Add something so one don't have to change the app id manually on every app id change.

Function Show-ChromeApps {
	# To list all registered apps from "Windows Start Menu" where app id contians "*chrome.*"
	# Get-StartApps | Where-Object { $_.AppID -like "*chrome.*" }
	# The AppID provided by the above command is sightly different (and will not work)from the one you will in the shortcut (.ink) property

	# Working AppID - 
	# For every folder starting with "_crx_" in the following directory-
	# "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Web Applications"
	# The Folder name will be the AppID and
	# the Icon File name inside those folder will be Name (Chrome PWA Name)
	# Return as [PSCustomObject]
	# [PSCustomObject]@{
	#         Name  = $AppName
	#         AppID = $AppId
	# }

	$Apps = Get-ChildItem -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Web Applications" -Directory -Filter "_crx_*" | ForEach-Object {
		$AppId = $_.Name -Replace '^_crx_', ''

		$IconFile = Get-ChildItem -Path $_.FullName -File | Where-Object {
			$_.Extension -in ".ico", ".png"
		} | Select-Object -First 1
		$AppName = if ($IconFile) { $IconFile.BaseName } else { "Unknown" }

		[PSCustomObject]@{
			Name  = $AppName
			AppID = $AppId
		}
		# SCOPE: Cross verify with the "Get-StartApps" and only mention those
	}	

	$Apps | Format-Table -AutoSize

	Write-Host -ForegroundColor DarkBlue "Usage:`n"
	Write-Host -ForegroundColor DarkYellow "`tStart application by passing the app id (--app-id) as an argument list (-ArgumentList) to chrome_proxy.exe`n"
	Write-Host -ForegroundColor DarkBlue "Example:`n"
	Write-Host -ForegroundColor DarkYellow "`tStart-Process `"path/to/chrome_proxy.exe`" -ArgumentList `"--app-id=yourappid`"`n`tOR`n`tStart-Process `"path/to/chrome_proxy.exe`" -ArgumentList `"--profile-directory=Default --app-id=yourappid`"`n"

	# Start application by passing the app id (--app-id) as an argument list (-ArgumentList) to chrome_proxy.exe
	# Start-Process "path/to/chrome_proxy.exe" -ArgumentList "--app-id=yourappid"
	# OR
	# Start-Process "path/to/chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=yourappid"
}
Set-Alias chromeapps Show-ChromeApps

Function Start-Chrome { 
	Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" 
}
Set-Alias chrome Start-Chrome

Function Start-Youtube { 
	$AppID = "agimnkijcaahngcdmfeangaknmldooml"
	Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$($AppID)" 
}
Set-Alias yt Start-Youtube

Function Start-ChatGPT { 
	$AppID = "cadlkienfkclaiaibeoongdcgmdikeeg"
	Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$($AppID)" 
}
Set-Alias chat Start-ChatGPT

Function Start-GitHub {
	$AppID = "mjoklplbddabcmpepnokjaffbmgbkkgg"
	Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$($AppID)" 
}
Set-Alias ghb Start-GitHub

Function Start-YoutubeWatchLaterInDefaultBrowser {
	Start-Process https://www.youtube.com/playlist?list=WL
}
Set-Alias watchlater Start-YoutubeWatchLaterInDefaultBrowser
Set-Alias wl Start-YoutubeWatchLaterInDefaultBrowser