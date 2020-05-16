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
#brew install go
brew install wget
brew cleanup

# Put screensaver on bottom right corner 
# http://secrets.blacktree.com/edit?id=2356
defaults write com.apple.dock wvous-br-corner -integer 5
defaults write com.apple.dock wvous-tr-corner -integer 4
killall Dock
# wait 5 secs before asking for password
defaults write com.apple.screensaver askForPasswordDelay -integer 5

# Setting up Screenrc
cp ~/dotfiles/screenrc ~/.screenrc

# Bash profile
#cp ~/dotfiles/bash_profile ~/.bash_profile

cd $OLDDIR
