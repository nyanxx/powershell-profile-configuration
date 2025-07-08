@echo off

cd C:\Users\<username>\local.bin\shortcuts\
start "" "Ubuntu"

REM powershell.exe -ExecutionPolicy RemoteSigned -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned; . 'C:\Users\<username>\local.bin\shortcuts\switchProfileUbuntu.ps1' -profileName Ubuntu"

exit
