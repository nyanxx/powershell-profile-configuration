Function Invoke-FromHistory {
	param([int]$HistoryNumber)
	try {
		if (!$HistoryNumber) {
			Write-Host "Enter history id!" -ForegroundColor Red
		} else {
			$ExpressionAsString = (Get-History $HistoryNumber).CommandLine.ToString()
		}
	} catch {
		Write-Host "Couldn't fetch history of id: $HistoryNumber" -ForegroundColor Red
		return
	}

	if($HistoryNumber) {
		Write-Verbose "Expression `"$ExpressionAsString`" invoked from Inovke-FromHistory function"
		Invoke-Expression $ExpressionAsString
	}
}
Set-Alias ifh Invoke-FromHistory
