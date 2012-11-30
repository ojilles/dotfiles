export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export HADOOP_HOME=~/hadoop
export PATH=~/pig/bin:$PATH
export HADOOPDIR=~/hadoop-conf
export HADOOPSITEPATH=$HADOOPDIR
export PIG_CLASSPATH=$HADOOPDIR
export OOZIE_HOME=~/oozie
export PIG_DIR="~/hadoop/pig/bin"
PATH="$HADOOP_INSTALL_DIR:$PATH:$PIG_DIR:$HADOOPDIR"
export PATH=$HADOOP_HOME/bin:$PATH:/usr/local/bin:~/bin
export SVN_EDITOR="/usr/bin/vim"
#export TERM=xterm-256color

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


# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value while retaining
# the original order. Use PATH if no <path> is given.
#
# Example:
#   $ puniq /usr/bin:/usr/local/bin:/usr/bin
#   /usr/bin:/usr/local/bin
puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# make grep colored
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    alias ls='ls -G'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# condense PATH entries
PATH=$(puniq $PATH)
MANPATH=$(puniq $MANPATH)

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -npsr
    uptime
}

set -o vi
