#!/bin/sh

mode='zsh'

if [[ -n $1 ]]; then
    mode=$1
fi


cp ~/.gitconfig ~/.gitconfig.old
cp ~/.zshrc ~/.zshrc.old
cp ~/.bashrc ~/.bashrc.old
cp ~/.tmux.conf ~/.tmux.conf.old
cp ~/.vimrc ~/.vimrc.old

case $mode in
    "zsh")
        echo "Linking config files for ZSH"
        ln -sfFv ~/.janat/zshrc.zsh ~/.zshrc
        ln -sfFv ~/.janat/gitconfig.cfg ~/.gitconfig
        ln -sfFv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "bash")
        echo "Linking config files for Bash"
        ln -sfFv ~/.janat/bashrc.bash ~/.bashrc
        ln -sfFv ~/.janat/gitconfig.cfg ~/.gitconfig;;
    "indeed" | "indeed-zsh")
        echo "Linking config files for ZSH Indeed"
        ln -sfFv ~/.janat/zshrc.indeed.zsh ~/.zshrc
        ln -sfFv ~/.janat/gitconfig.indeed.cfg ~/.gitconfig
        ln -sfFv ~/.janat/p10k.zsh ~/.p10k.zsh;;
    "indeed-bash")
        echo "Linking config files for Bash Indeed"
        ln -sfFv ~/.janat/bashrc.indeed.bash ~/.bashrc
        ln -sfFv ~/.janat/gitconfig.cvm.cfg ~/.gitconfig;;
esac

echo "Linking base config files"
ln -sfFv ~/.janat/tmux.conf ~/.tmux.conf
[[ -d ~/.vim ]] && (rm ~/.vim.old; mv ~/.vim ~/.vim.old)
ln -sfFv ~/.janat/vim ~/.vim
vim -c 'PlugInstall' -c 'qa!'
echo "Linking complete!"