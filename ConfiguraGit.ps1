git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.rb rebase
git config --global alias.compare "! f() { git rev-list --left-right --count \${2-HEAD}...\${1-master}; }; f"
