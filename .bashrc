#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If $HOME/bin exists and isn't on $PATH, prepend it
if [ -d "$HOME/bin" ] && [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  PATH=$HOME/bin:$PATH
fi

# If $HOME/.local/bin exists and isn't on $PATH, append it
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  PATH=$PATH:$HOME/.local/bin
fi

# Command-not-found (AUR)
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

# Source .bash_functions if exists
[ -r $HOME/.bash_functions ] && . $HOME/.bash_functions

# Source .bash_tput if exists
[ -r $HOME/.bash_tput ] && . $HOME/.bash_tput

# fuck
eval $(thefuck --alias)

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. $HOME/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh

# Sane file permissions: u=rwx,g=rx,o=
umask 0027

# Set environment variables
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="${txtcyn}%h %d ${txtgrn}%H:%M:%S ${txtwht}> "
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export TERM=xterm-256color

# Custom environment variables
export SCREENSHOTDIR="$HOME/Pictures/Screenshots"
export WINCAPTUREDIR="$HOME/Pictures/Window Captures"

# Set bash options
shopt -s histappend
shopt -s checkwinsize
shopt -s mailwarn
shopt -s autocd
shopt -s cdable_vars
shopt -s histverify

# Define useful aliases
alias ls='ls --color=auto -N'
alias rmed='find -type d -empty -delete'
alias emacs='emacs -nw'

# Define lazy aliases
alias startplex='sudo systemctl start plexmediaserver'
alias stopplex='sudo systemctl stop plexmediaserver'

# Customise prompt
#PS1='[\u@\h \W] \$ '
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#PS1='\n[${txtmgt}\w${txtwht}]\n[${txtcyn}\u@\h${txtwht}] \$ '

# Show useful info to user

echo 

# IP Address
ipaddr

# Filesystem space (colourise later)
echo
sudo btrfs fi show | sed -n '/mapper/p;' | cut -d " " -f 4-

# Fortune cookies
echo
fortune -eos computers linux
echo
