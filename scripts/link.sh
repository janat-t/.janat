#!/bin/sh

set -e

mode='zsh'

if [ -n $1 ]; then
    mode=$1
fi


[ -e ~/.gitconfig ] && mv -f ~/.gitconfig ~/.gitconfig.old
[ -e ~/.tmux.conf ] && mv -f ~/.tmux.conf ~/.tmux.conf.old
[ -d ~/.vim ] && ([ -d ~/.vim.old ] && rm ~/.vim.old; mv ~/.vim ~/.vim.old)

case $mode in
    "zsh")
        echo "Linking config files for ZSH"
        [ -e ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old
        ln -sfFv ~/.janat/zshrc.zsh ~/.zshrc
        ln -sfFv ~/.janat/gitconfig.cfg ~/.gitconfig
        ln -sfFv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "bash")
        echo "Linking config files for Bash"
        [ -e ~/.bashrc ] && mv -f ~/.bashrc ~/.bashrc.old
        ln -sfFv ~/.janat/bashrc.bash ~/.bashrc
        ln -sfFv ~/.janat/gitconfig.cfg ~/.gitconfig;;
    "indeed" | "indeed-zsh")
        echo "Linking config files for ZSH Indeed"
        [ -e ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old
        ln -sfFv ~/.janat/zshrc.indeed.zsh ~/.zshrc
        ln -sfFv ~/.janat/gitconfig.indeed.cfg ~/.gitconfig
        ln -sfFv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "cvm" | "indeed-bash")
        echo "Linking config files for Bash Indeed"
        [ -e ~/.bashrc ] && mv -f ~/.bashrc ~/.bashrc.old
        ln -sfFv ~/.janat/bashrc.cvm.bash ~/.bashrc
        ln -sfFv ~/.janat/gitconfig.cvm.cfg ~/.gitconfig;;
esac

echo "Linking base config files"
ln -sfFv ~/.janat/tmux.conf ~/.tmux.conf
ln -sfFv ~/.janat/vim ~/.vim
vim -c 'PlugInstall' -c 'qa!'
echo "Linking complete!"
