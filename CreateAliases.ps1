$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Import-Module "$root\Modules\posh-alias\Posh-Alias.psd1"
Set-Alias pester invoke-pester
Set-Alias psake invoke-psake
Set-Alias k kubectl
Set-Alias stopc Stop-Computer
Set-Alias restartc Restart-Computer
Set-Alias d docker
Set-Alias dc docker-compose
function add {
    if ($args) {
        Invoke-Expression ( "git add " + ($args -join ' ') )
    }
    else {
        git add -A :/
    }
}
Add-Alias st 'git status'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias log 'git log'
Add-Alias ci 'git commit'
Add-Alias co 'git checkout'
Add-Alias dif 'git diff'
Add-Alias rs 'git reset'
Add-Alias rb 'git rebase'
Add-Alias fixup 'git fixup'
Add-Alias branch 'git branch'
Add-Alias branches 'git branches'
Add-Alias tag 'git tag'
Add-Alias up 'git up'
Add-Alias sync 'git sync'
Add-Alias l 'ls'
Add-Alias ll 'ls -Force'
Add-Alias gitbash '. "C:\Program Files\Git\usr\bin\bash.exe"'
Add-Alias ccat "pygmentize.exe -g -O style=vs -f console16m"
# if (Get-Command hub -ErrorAction Ignore) {
#     Add-Alias git "$($(Get-Command hub).Source)"
# }
if (Get-Command curl -CommandType Application -ErrorAction Ignore) {
    #use system curl if available
    if (Get-Alias curl -ErrorAction Ignore) {
        Remove-Item alias:curl
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
