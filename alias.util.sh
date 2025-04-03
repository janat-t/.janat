#!/bin/sh

alias bashrc='vim ~/.bashrc'
alias c='gcc -o run'
alias cpp='g++ -std=c++17 -o run'
alias jupynote='jupyter notebook'
alias l='ls -lahF'
alias m='make'
alias myip='curl https://ipv4.wtfismyip.com/json; echo'
alias npm-update='npx npm-check -u'
alias path="echo \$PATH | sed 's/:/\\n/g'"
alias pg="echo 'Pinging Google' && ping www.google.com"
alias pip='pip3'
alias pippypy='pip_pypy3'
alias py='python3'
alias pypy='pypy3'
alias python='python3'
alias runp='lsof -i '
alias settm='vim ./.tmux.workspace.sh'
alias tf='terraform'
alias tm='tmux'
alias tmconf='vim ~/.tmux.conf'
alias tmx='./.tmux.workspace.sh'
alias topten='history | commands | sort -rn | head'
alias usage='du -h -d1'
alias vimrc='vim ~/.vim/vimrc'
alias zshrc='vim ~/.zshrc'

commands() {
  awk '{a[$2]++}END{for(i in a){print a[i] " " i}}'
}

mdcd() {
    mkdir $1
    cd $1
}

pyserve() {
    python3 -m http.server "$1"
}

