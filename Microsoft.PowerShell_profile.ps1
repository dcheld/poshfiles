$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$isWin = [System.Environment]::OSVersion.Platform -eq 'Win32NT'
if ($isWin -and $null -eq $env:HOME -and $null -ne $env:USERPROFILE) {
    $env:HOME = $env:USERPROFILE
}

# . "$root/InstallModules.ps1"

if ($isWin -and (Test-Path "$env:ProgramFiles\Git\usr\bin") -and ($env:path.IndexOf("$($env:ProgramFiles)\Git\usr\bin", [StringComparison]::CurrentCultureIgnoreCase) -lt 0)) {
    # enable ssh-agent from posh-git
    $env:PATH = "$env:PATH;$env:ProgramFiles\Git\usr\bin"
}
Import-Module "$root/Modules/posh-git/src/posh-git.psd1"
Import-Module "$root/Modules/oh-my-posh/oh-my-posh.psm1" #don't import the psd1, it has an incorrect string in the version field
Import-Module "$root/Modules/PowerShellGuard/PowerShellGuard.psm1" #don't import the psd1, it has an incorrect string in the version field
# Import-Module "$root/Modules/MSTerminalSettings/src/MSTerminalSettings.psd1"
# Import-Module "$root/Modules/DockerComposeCompletion/DockerComposeCompletion/DockerComposeCompletion.psd1"
# Import-Module "$root/Modules/DockerCompletion/DockerCompletion/DockerCompletion.psd1"
# Import-Module "$root/Modules/Invoke-MsBuild/src/Invoke-MsBuild/Invoke-MsBuild.psd1"
# Import-Module "$root/Modules/psake/src/psake.psd1"

if ($isWin) { Import-Module $root\Modules\z\z.psm1 }

$ThemeSettings.MyThemesLocation = Join-Path $root PoshThemes
Set-Theme "Powerlevel10k-Classic"
if (Get-Command colortool -ErrorAction Ignore) { colortool --quiet campbell }

# $kubeConfigHome = Join-Path $env:HOME '.kube'
# if (Test-Path $kubeConfigHome) {
#     $env:KUBECONFIG = Get-ChildItem $kubeConfigHome -File | ForEach-Object { $kubeConfig = '' } { $kubeConfig += "$($_.FullName)$([System.IO.Path]::PathSeparator)" } { $kubeConfig }
#     Remove-Variable kubeConfig
# }
# Remove-Variable kubeConfigHome

# . "$root/InstallTools.ps1"
. "$root/Completions.ps1"
. "$root/PSReadlineConfig.ps1"
. "$root/CreateAliases.ps1"
. "$root/Functions.ps1"

$root = $null
