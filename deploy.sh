#! /bin/bash
OLDDIR=`pwd`

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Update homebrew recipes
echo "Updating brew recipes"
# brew update

echo "Installing a few brew apps"
# install a bunch of brew stuff
# see f.ex. http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
brew install tree
brew install go
brew install wget
# brew install hub # easy github integration on command line, see 'brew home hub'
brew cleanup

# # Cask
# echo "Installing Brew Cask"
# brew tap phinze/homebrew-cask
# #cd /usr/local/Library/Taps/phinze/homebrew-cask
# #git remote set-url origin git@github.com:phinze/homebrew-cask.git
# brew install brew-cask
# brew cask update
# 
# # Apps
# echo 'Installing applications through Brew Cask (chrome etc)'
# apps=(
# 	dropbox
# 	google-chrome
# 	qlmarkdown
# 	vagrant
# 	arq
# 	iterm2
# 	flux
# 	skype
# )
# 
# # Install apps to /Applications
# # Default is: /Users/$user/Applications
# echo "installing apps..."
# brew cask install --appdir="/Applications" ${apps[@]}
# exit

# Put screensaver on bottom right corner 
# http://secrets.blacktree.com/edit?id=2356
defaults write com.apple.dock wvous-br-corner -integer 5
killall Dock
# wait 5 secs before asking for password
defaults write com.apple.screensaver askForPasswordDelay -integer 5

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

~/dotfiles/osx-for-hackers.sh
