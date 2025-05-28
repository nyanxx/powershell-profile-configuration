# Start Alpine WSL
Function Start-AlpineWSL { wsl.exe --distribution alpine }
Set-Alias alpine Start-AlpineWSL

# Start Kali-Linux WSL
Function Start-KaliLinuxWSL { wsl.exe --distribution kali-linux }
Set-Alias kali Start-KaliLinuxWSL

# Shutdown WSL
Function Shutdown-WSL {
        Write-Host "Shutting Down WSL..."
        wsl.exe --shutdown
}
Set-Alias wsldown Shutdown-WSL

# Temporary Solution To Open Distros in Explorer Shell
Function Open-WSLDistrosInExplorer {
	Try {
		Start-Process -FilePath "$HOME/Desktop/UN_do/Linux-Open.lnk" -ErrorAction Stop
		# Above `-ErrorAction Stop` works like `break` keyword
	} Catch {
		Write-Host "'Linux-Open.lnk' File not found!" -ForegroundColor Red
		#Write-Host "$($_.Exception.Message)"
	}
}
Set-Alias expds Open-WSLDistrosInExplorer
