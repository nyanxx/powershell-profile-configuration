# profile_aliases.ps1
# Get-Alias : Get all available aliases on system.
# Set-Alias : Set or replace an alias.
# New-Alias : Set a new alias, if already exist throws an error.

# In Linux you can add argumnets, options or pipelines while creating an alias but here on Windows the only way i know of is you create a function and then asign an alias to newly created function.

Set-Alias exp explorer.exe

Set-Alias v nvim

Set-Alias which where.exe

Set-Alias grep findstr.exe

Set-Alias gog Search-QueryOnGoogle.exe

Function Create-File { $null > $args }
Set-Alias touch Create-File

Function Show-EnvironmentalVariables { Get-ChildItem env: }
Set-Alias env Show-EnvironmentalVariables

Function Open-RecycleBin { Start-Process shell:RecycleBinFolder }
Set-Alias rbin Open-RecycleBin

# Git #####

Function Git-Status { git status }
Set-Alias gs Git-Status

Function Git-Add($file) { git add $file }
Set-Alias ga Git-Add

#Function Git-Restore { logic }
#Set-Alias xx Git-Restore

Function Git-Commit {
	param([String]$msg)
	git commit -m "$msg"
}
Set-Alias gcom Git-Commit

Function Get-GitAliases {
	Write-Host "`n`tgs - git status"
	Write-Host "`tga - git add ."
	Write-Host "`tgcom - git commit -m `"argument`""
	Write-Host "`tgh - List aliases related to Git`n"
}
Set-Alias gh Get-GitAliases

###########

Function Show-JobCmdlets { Get-Alias | findstr.exe Job }
Set-Alias jobh Show-JobCmdlets

# TODO : Rather than making a function i can also add the exe to user PATH.
Function Start-HWiNFO { Start-Process -FilePath "C:\Package Bin\hwi_822\HWiNFO64.exe"}
Set-Alias info Start-HWiNFO

Function Start-Obsidian { Start-Process -FilePath "$HOME\AppData\Local\Programs\Obsidian\Obsidian.exe" }
Set-Alias obs Start-Obsidian

Function Run-AdminPowershell { Start-Process pwsh.exe -Verb RunAs }
Set-Alias admin Run-AdminPowershell

Function Start-MicrosoftSettings { Start-Process "ms-settings:"}
Set-Alias settings Start-MicrosoftSettings

Function Restart-PowershellSession {
	Stop-Process -Name pwsh -Force
	Start-Process pwsh
}
Set-Alias rps Restart-PowershellSession

Function Start-NeovimWithTelescope { 
	#nvim -c Telescope 
	nvim -c "Telescope find_files"
}
Set-Alias tel Start-NeovimWithTelescope
