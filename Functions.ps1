function add {
    if ($args) {
        Invoke-Expression ( "git add " + ($args -join ' ') )
    }
    else {
        git add -A :/
    }
}

function pushsync() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [string] $RemoteName = "origin"
    )

    $branch = $(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream $RemoteName $branch
}

if ($isWin) {
    function time() {
        $sw = [Diagnostics.Stopwatch]::StartNew()
        Invoke-Expression $($args -join ' ')
        $sw.Stop()
        $sw.elapsed
    } # call like: `time ls` or `time git log`
}

function Remove-FromPath {
    Param( [parameter(Mandatory = $true)][String]$pathToRemove)
    $exists = ($env:path.Split(';') | Where-Object { $_ -eq $pathToRemove })
    if (!$exists) {
        throw "Path not found."
    }
    $env:path = ($env:path.Split(';') | Where-Object { $_ -ne $pathToRemove }) -join ';'
}

function Remove-Dotnet-Bin(){
    Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }
}

function Load-VSTools {
    if ($isWin) {
        $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
        if (Test-Path $vswhere) {
            [array]$vss = . $vswhere -Property installationPath
            if ($vss.Count -ne 0) {
                $vsPath = $vss[0]
                Import-Module "$vsPath\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
                Enter-VsDevShell -VsInstallPath $vsPath > $null
            }
        }
        elseif (Get-Module VSSetup) {
            [array]$vss = Get-VSSetupInstance | Where-Object { $_.InstallationVersion.Major -ge 17 } | Select-Object -Property InstallationPath -First 1
            if ($vss.Count -ne 0) {
                $vsPath = $vss[0].InstallationPath
                Import-Module "$vsPath\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
                Enter-VsDevShell -VsInstallPath $vsPath > $null
            }
        }
    }
}
