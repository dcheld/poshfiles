#!/usr/bin/env pwsh

$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$isWin = [System.Environment]::OSVersion.Platform -eq 'Win32NT'

if ($isWin -and $null -eq $env:HOME -and $null -ne $env:USERPROFILE) {
    $env:HOME = $env:USERPROFILE
}

Import-Module -Scope Local -Name "$root/Modules/posh-alias/Posh-Alias.psm1"
Import-Module -Scope Local -Name "$root/Modules/z/z.psm1"
. "$root/ImportModuleOMP.ps1"

if (Get-Command colortool -ErrorAction Ignore) { colortool --quiet campbell }

. "$root/Completions.ps1"
. "$root/PSReadlineConfig.ps1"
. "$root/CreateAliases.ps1"
. "$root/Functions.ps1"

$root = $null
