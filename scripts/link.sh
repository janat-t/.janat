ln -sfF ~/.janat/zshrc ~/.zshrc
ln -sfF ~/.janat/bashrc ~/.bashrc
ln -sfF ~/.janat/tmux.conf ~/.tmux.conf
ln -sfF ~/.janat/p10k.zsh ~/.p10k.zsh
ln -sfF ~/.janat/vim ~/.vim
ln -sfF ~/.janat/gitconfig ~/.gitconfig
vim -c 'PlugInstall' -c 'qa!'
