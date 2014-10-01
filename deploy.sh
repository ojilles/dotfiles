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

# Setup javascript indenting
cd ~/.vim/bundle
git clone https://github.com/pangloss/vim-javascript.git

# Setting up vim
mkdir -p ~/.vim/sessions
cp ~/dotfiles/vimrc ~/.vimrc

# Setting up Screenrc
cp ~/dotfiles/screenrc ~/.screenrc

# Bash profile
cp ~/dotfiles/bash_profile ~/.bash_profile

cd $OLDDIR

echo "Installing go tools"
#### Some go stuff I use
command -v $GOPATH/bin/go-bindata >/dev/null 2>&1 || {
	echo "Installing go-bindata as it's a dependency"
	go get github.com/jteeuwen/go-bindata/...
}
command -v $GOPATH/bin/goxc >/dev/null 2>&1 || {
	echo "Installing goxc as it's a dependency"
	go get github.com/laher/goxc
}
