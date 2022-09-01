#Powershell script to workaround the certificate issue on WinFi
#Instructions:
## 1. Install WinFi
## 2. Copy this script winfi.ps1 in the installation folder of WinFi: C:\Program Files (x86)\Helge Keck\WinFi
## 3. Copy the shortchut in the installation folder of WinFi. The shortcut is using the following command to start the script: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -ExecutionPolicy Bypass -File "C:\Program Files (x86)\Helge Keck\WinFi\winfi.ps1"
## 4. Add the shortcut to your Start bar
## 5. Enjoy this great software from Helge Keck

#Credits for this script: Jonathan Rambeau, Andrey Paramonov

#Function to run PS as Administrator (thanks to Andrey)
param([switch]$Elevated)
function Test-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) }
if ((Test-Admin) -eq $false)  { 
    if ($elevated){ # Could not elevate, quit
} else { 
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ( $myinvocation.MyCommand.Definition ))
    } exit
}

#Changing date and starting WinFi
$today = Get-Date
$pastday = Get-Date -Year 2022 -Month 03 -Day 01    #Set a date before certificate issue
Set-Date $pastday
Start-Process "C:\Program Files (x86)\Helge Keck\WinFi\WinFi.exe"
Start-Sleep -Seconds 10
Set-Date $today.AddSeconds(10)