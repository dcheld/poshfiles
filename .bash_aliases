alias sudo="sudo "
alias g=git
alias st='git status'
alias push='git push'
alias pull='git pull'
alias log='git log'
alias ci='git commit'
alias co='git checkout'
alias dif='git diff'
alias rs='git reset'
alias rb='git rebase'
alias fixup='git fixup'
alias branch='git branch'
alias branches='git branch -a'
alias tag='git tag'
alias up='git up'
alias sync='git sync'
alias groot='cd "$(git rev-parse --show-cdup)"'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias gfd="find . -maxdepth 1 -type d -exec git --git-dir={}/.git --work-tree=$PWD/{} fetch \;"

function juspark(){
    PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark
}

function pushsync() {
    remote="${1:-origin}"
    branch=$(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream $remote $branch
}

function emd5sum() {
    echo -n $@ | md5sum | awk '{print $1}' | xargs echo
}

function add {
    if [ $# -ne 0 ]; then
        git add "$@"
    else
        git add -A :/
    fi
}
