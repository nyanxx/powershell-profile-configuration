Function Syncthing-Interact {
	param([string]$attb)

	# Private function (originally a script block in variable), encapsulated within Syncthing-Interact. &:call operator is used to call the script/code from the variable
    	$SyntRunning = {
        	# Function logic for checking if Syncthing is running
        	$ProcessIdSynt = Get-Process -ProcessName syncthing -ErrorAction SilentlyContinue
        	return $ProcessIdSynt -ne $null
    	}

	switch ($attb) {
		"" { Start-Process -FilePath "$HOME\AppData\Local\Programs\Syncthing\stctl.exe" -ArgumentList "--start";}
		"start" { Start-Process -FilePath "$HOME\AppData\Local\Programs\Syncthing\stctl.exe" -ArgumentList "--start" }
		"stop" { Start-Process -FilePath "$HOME\AppData\Local\Programs\Syncthing\stctl.exe" -ArgumentList "--stop" }
		"config" { Start-Process -FilePath "$HOME\AppData\Local\Programs\Syncthing\ConfigurationPage.url" }
		"help" { Write-Host "`n`nSyncthing(synt) `nSimple Commands To Interact With Syncthing`n`n`tstart : Start Syncthing Server `n`tstop : Stop Syncthing Server `n`tconfig : Open Web Config in Default Browser `n`thelp : Show Help`n`n" }
		"status" {
			if (& $SyntRunning) {
				Write-Host "Syncthing Server is up and running, use 'synt config' to access server settings." -ForegroundColor Green
			}
			else {
				Write-Host "Synthing Server is not active." -ForegroundColor Red
			} 
		}
		default { Write-Host "`'$attb`' is not a proper parameter of synt, use 'synt help' for more info." -ForegroundColor Red}
		}
} 
New-Alias synt Syncthing-Interact



#Function Private:Synt-Running {
	#$ProcessIdSynt = (ps syncthing -ErrorAction SilentlyContinue ).Id -join "," 
#	$ProcessIdSynt = ps syncthing -ErrorAction SilentlyContinue
#	return $ProcessIdSynt -ne $NULL
	# One can even use the -not thingy like : return -not $ProcessIdSynt, if its null then it's true, -not is not an opposite of -eq it -ne which means not equal
#}











#  ps syncthing | Format-Table Id | grep [0-9]
#  ps syncthing | Format-Table Id
#
#Add-Type -AssemblyName System.Windows.Forms
#$msgBoxInput = [System.Windows.Forms.MessageBox]::Show("Your Message Here", "Title", "OK", "Information")
#[System.Windows.Forms.MessageBox]::Show("Your Message Here", "Title", "OK", "Information")
#
# for synt start and simply synt -> check if syncthing is running -> if running do nothing the app will take care of msg -> if not running let the command start, then check if activated based on that show msg.
# 
# for synt stop -> check if the syncthing is running or not -> if its running run the command to stop it and show the msg that the sever is closed successfully -> if the syncthing is not running at start let the command / app deal with the msg.
#
# for synt config -> check syncthing process is running or not -> based on that proceed gracefully either open run the command of show msg of server not running and first start the server.
#
# REF!:https://superuser.com/questions/1682641/how-to-check-if-process-is-running-properly-in-powershell
