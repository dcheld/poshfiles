#!/usr/bin/env pwsh

Set-PSReadlineOption -EditMode Windows
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key Shift+Tab -Function TabCompletePrevious