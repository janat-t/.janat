#!/bin/sh

set -e

mode='zsh'

if [ -n "$1" ]; then
    mode=$1
fi


[ -e ~/.gitconfig ] && mv -f ~/.gitconfig ~/.gitconfig.old
[ -e ~/.tmux.conf ] && mv -f ~/.tmux.conf ~/.tmux.conf.old
[ -d ~/.vim ] && ([ -d ~/.vim.old ] && rm ~/.vim.old; mv ~/.vim ~/.vim.old)
mkdir -p ~/.config
[ -d ~/.config/nvim ] && ([ -d ~/.config/nvim.old ] && rm ~/.config/nvim.old; mv ~/.config/nvim ~/.config/nvim.old)

case $mode in
    "zsh")
        echo "Linking config files for ZSH"
        [ -e ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old
        ln -sfv ~/.janat/zshrc.zsh ~/.zshrc
        ln -sfv ~/.janat/gitconfig.cfg ~/.gitconfig
        ln -sfv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "bash")
        echo "Linking config files for Bash"
        [ -e ~/.bashrc ] && mv -f ~/.bashrc ~/.bashrc.old
        ln -sfv ~/.janat/bashrc.bash ~/.bashrc
        ln -sfv ~/.janat/gitconfig.cfg ~/.gitconfig;;
    "ubuntu")
        echo "Linking config files for ZSH Ubuntu"
        [ -e ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old
        ln -sfv ~/.janat/zshrc.ubuntu.zsh ~/.zshrc
        ln -sfv ~/.janat/gitconfig.cfg ~/.gitconfig
        ln -sfv ~/.janat/p10k.ubuntu.zsh ~/.p10k.zsh;;
    "indeed" | "indeed-zsh")
        echo "Linking config files for ZSH Indeed"
        [ -e ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old
        ln -sfv ~/.janat/zshrc.indeed.zsh ~/.zshrc
        ln -sfv ~/.janat/gitconfig.indeed.cfg ~/.gitconfig
        ln -sfv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "cvm" | "indeed-bash")
        echo "Linking config files for Bash Indeed"
        [ -e ~/.bashrc ] && mv -f ~/.bashrc ~/.bashrc.old
        ln -sfv ~/.janat/bashrc.cvm.bash ~/.bashrc
        ln -sfv ~/.janat/gitconfig.cvm.cfg ~/.gitconfig;;
esac

echo "Linking base config files"
ln -sfv ~/.janat/tmux.conf ~/.tmux.conf
ln -sfv ~/.janat/vim ~/.vim
ln -sfv ~/.janat/nvim ~/.config/nvim
vim -c 'PlugInstall' -c 'qa!'
nvim -c 'PlugInstall' -c 'qa!'
echo "Linking complete!"
