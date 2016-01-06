#
# ~/.bashrc
#

# TODO: switch to tput for terminal manipulation


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Command-not-found (AUR)
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

# Source .bash_functions if exists
[ -r $HOME/.bash_functions ] && . $HOME/.bash_functions

# Sane file permissions: u=rwx,g=rx,o=
umask 0027

# Set environment variables
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%h %d %H:%M:%S > "  # TODO: colourise time
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PATH=$HOME/bin:$PATH

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
alias ls='ls --color=auto'
alias rmed='find -type d -empty -delete'
alias emacs='emacs -nw'

# Define lazy aliases
alias startplex='sudo systemctl start plexmediaserver'
alias stopplex='sudo systemctl stop plexmediaserver'

# Customise prompt
#PS1='[\u@\h \W]\$ '

export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007" & history -a;$PROMPT_COMMAND'
PS1='\n[\W\[\e[0m\]]\n[\[\e[0;32m\]\u@\h\[\e[0;36m\]]\$ '

# Show useful info to user

echo 

# Set default browser if X is running
if [ "$DISPLAY" ]
then
  xdg-settings set default-web-browser google-chrome-stable.desktop
  echo "Attempting to set Google Chrome as default browser."
else
  echo "No X session running."
fi

# IP Address
ipaddr

# Filesystem space (colourise later)
echo
df -h | sed -n '1p;/mapper/p'
echo
echo /
btrfs filesystem df /
echo
echo /home
btrfs filesystem df /home

# Fortune cookies
echo
fortune -eos computers linux
echo
