BACKUP=~/.backup-old-dotfiles
mkdir -p $BACKUP

mv ~/.vim* $BACKUP/
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc

