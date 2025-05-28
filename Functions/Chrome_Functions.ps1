Import-Module -Name "$PROFILE_DIR/Functions/Modules/getId/getId.psm1"

# Start Youtube ( Chrome App )
Function yt { Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$(getId("YouTube"))" }

# Start ChatGPT ( Chrome App )
Function chat { Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$(getId("ChatGPT"))" }

# "C:\Program Files\Google\Chrome\Application\chrome.exe"
Function Start-ChromeExe { Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" }
Set-Alias chrome Start-ChromeExe

Function Start-WatchLaterInDefaultBrowser {
	 Start-Process https://www.youtube.com/playlist?list=WL
}
Set-Alias watchlater Start-WatchLaterInDefaultBrowser
Set-Alias wlat Start-WatchLaterInDefaultBrowser

# Start GitHub ( Chrome App )
Function Start-GitHubChromeApp { Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" -ArgumentList "--profile-directory=Default --app-id=$(getId("GitHub"))" }
Set-Alias ghb Start-GitHubChromeApp
