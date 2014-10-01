#! /bin/bash
OLDDIR=`pwd`

# Install Pathogen for vim
echo "Installing Pathogen for vim..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Go tooling for Vim
echo "Installing Go Vim"
cd ~/.vim/bundle
rm -rf ~/.vim/bundle/vim-go
git clone https://github.com/fatih/vim-go.git

# Setting up vim
mkdir -p ~/.vim/sessions
cp ~/dotfiles/vimrc ~/.vimrc

# Setting up Screenrc
cp ~/dotfiles/screenrc ~/.screenrc

# Bash profile
cp ~/dotfiles/bash_profile ~/.bash_profile

cd $OLDDIR
