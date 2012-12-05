export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export SVN_EDITOR="/usr/bin/vim"

# MacPorts Installer addition on 2010-12-07_at_16:00:02: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Some inpsiration from: https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc
# fuck that you have new mail shit
unset MAILCHECK
# disk usage with human sizes and minimal depth
alias du1='du -h --max-depth=1'
alias fn='find . -name'
alias hi='history | tail -20'
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# set a fancy prompt (non-color, unless we know we "want" color)
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# make grep colored
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

