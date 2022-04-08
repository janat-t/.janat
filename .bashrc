# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/share/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/share/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/share/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/share/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [[ -r "$HOME/.janat/.alias.dir" ]]; then
    source "$HOME/.janat/.alias.dir"
fi

if [[ -r "$HOME/.janat/.alias.git" ]]; then
    source "$HOME/.janat/.alias.git"
fi

if [[ -r "$HOME/.janat/.alias.util" ]]; then
    source "$HOME/.janat/.alias.util"
fi

test -s ~/.alias && . ~/.alias || true

# User configuration

alias update='source ~/.bashrc'

# Server Side Jupyter link
alias jl='lsof -ti:8870 | xargs kill -9;jupyter notebook --no-browser --port=8870'
