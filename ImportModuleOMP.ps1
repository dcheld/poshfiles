#!/usr/bin/env pwsh

if (Get-Command oh-my-posh -CommandType Application -ErrorAction Ignore) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
}