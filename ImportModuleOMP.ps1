#!/usr/bin/env pwsh

function GetPathForSystem() {
    if ($isWin) {
        return "$env:LOCALAPPDATA\Program\oh-my-posh\themes";
    }
    else {
        return "/usr/share/oh-my-posh/themes";
    }
}

if (Get-Command oh-my-posh -CommandType Application -ErrorAction Ignore) {
    $Variable:CURRENT_THEME = ${env:POSH_THEMES_PATH} ?? $(GetPathForSystem);
    $Variable:CURRENT_THEME = Join-Path $Variable:CURRENT_THEME "powerlevel10k_rainbow.omp.json"
    oh-my-posh init pwsh --config $Variable:CURRENT_THEME | Invoke-Expression
}

