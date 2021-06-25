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
alias secon="$HOME/serasa_connection/serasa_connection.sh"
alias sdev1="$HOME/serasa_connection/serasa_connection.sh ssh dev1"
alias tdev1="$HOME/serasa_connection/serasa_connection.sh tunnel dev1"
alias sdev2="$HOME/serasa_connection/serasa_connection.sh ssh dev2"
alias tdev2="$HOME/serasa_connection/serasa_connection.sh tunnel dev2"
alias shm01="$HOME/serasa_connection/serasa_connection.sh ssh hm01"
alias thm01="$HOME/serasa_connection/serasa_connection.sh tunnel hm01"
alias shm02="$HOME/serasa_connection/serasa_connection.sh ssh hm02"
alias thm02="$HOME/serasa_connection/serasa_connection.sh tunnel hm02"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias scloud='ssh -o "IdentitiesOnly yes" -i "/opt/dev/aws-serasa/ec2-chronos-pj.pem" -fCqND 8124 hadoop@10.99.206.217'
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
