#!/usr/bin/env pwsh

$isWin = [System.Environment]::OSVersion.Platform -eq 'Win32NT'

if ($isWin){
    winget install JanDeDobbeleer.OhMyPosh -s winget
}
else {
    yay oh-my-posh-bin
}
Install-Module -Scope CurrentUser -Name posh-alias
Install-Module -Scope CurrentUser -Name z
