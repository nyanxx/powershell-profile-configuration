# Start Alpine WSL
Function Start-AlpineWSL { wsl.exe --distribution alpine }
New-Alias alpine Start-AlpineWSL

# Start Kali-Linux WSL
Function Start-KaliLinuxWSL { wsl.exe --distribution kali-linux }
New-Alias kali Start-KaliLinuxWSL

# Shutdown WSL
Function Shutdown-WSL {
        Write-Host "Shutting Down WSL..."
        wsl.exe --shutdown
}
New-Alias wsldown Shutdown-WSL

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
New-Alias expds Open-WSLDistrosInExplorer
