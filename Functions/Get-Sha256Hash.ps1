Function Get-Sha256($text) {
try{
	return [System.BitConverter]::ToString([System.Security.Cryptography.SHA256Managed]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($text))).Replace("-","")
} catch {
	Write-Error "Provide some text!"
}	
}
