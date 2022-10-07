function color ($lexer = 'javascript') {
    Begin { $t = "" }
    Process {
        $t = "$t
    $_"
    }
    End { $t | pygmentize.exe -l $lexer -O style=vs -f console16m; }
} # call like: `docker inspect foo | color`

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

function Install-Theme {
    Param( [parameter(Mandatory = $true)][String]$theme)
    $themePath = "~\Documents\Themes\$theme.itermcolors"
    if(!(Test-Path $themePath)) {
        Invoke-RestMethod -Uri "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/$theme.itermcolors" -OutFile $themePath
        Import-Iterm2ColorScheme -Path $themePath -Name $theme
    }
    Get-MSTerminalProfile -Name "PowerShell Core 7" | Set-MSTerminalProfile -ColorScheme $theme
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

