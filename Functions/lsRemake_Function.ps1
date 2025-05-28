# Here Get-ChildItem will not display items starting with "."
Function Get-ChildItemRemake {
	param ( [string]$dir )
	#Get-ChildItem -Path $dir -Exclude .*
	Get-ChildItem -Path $dir | Where-Object { $_.Name -notmatch '^\.' }
}

# Set alias 'ls' pointing to Get-ChildItemRemake
Set-Alias ls Get-ChildItemRemake

# Set alias 'la' pointing to the original Get-ChildItem
Set-Alias la Get-ChildItem

