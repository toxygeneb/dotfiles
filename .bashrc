#
# ~/.bashrc
#

# TODO: switch to tput for terminal manipulation


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Sane file permissions: u=rwx,g=rx,o=
umask 0027

# Set environment variables
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%h %d %H:%M:%S > "  # TODO: colourise time

# Export environment variables
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PATH=$HOME/bin:$PATH

# Custom environment variables
SCREENSHOTDIR="$HOME/Pictures/Screenshots"
WINCAPTUREDIR="$HOME/Pictures/Window Captures"

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
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#PS1='[\u@\h \W]\$ '
PS1='\n[\W\[\e[0m\]]\n[\[\e[0;32m\]\u@\h\[\e[0;36m\]]\$ '

# Command-not-found (AUR)
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

# Assorted useful functions
# (Should probably sort into a separately sourced file)

# IP Info
ipinfo() {
  if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
      curl ipinfo.io/"$1"
  else
    ipawk=($(host "$1" | awk '/address/ { print $NF }'))
    curl ipinfo.io/${ipawk[1]}
  fi
  echo
}

# Define a word
define() {
  lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/lookup
  if [[ -s  /tmp/lookup ]]; then 
    until ! read response; do
      echo "${response}"
    done < /tmp/lookup
  else
    echo "Sorry $USER, I can't find the term \"${1} \""                
  fi    
  rm -f /tmp/lookout
}

# Urban Dictionary definition
urband() {
  echo
  wget -q -O - www.urbandictionary.com/define.php?term=$1 | grep -A1 -P 'meaning' | grep  "^[^<-]" > /tmp/urbanlist
  awk '{print NR, ". ", $0, "\n"}' < /tmp/urbanlist
  rm -f /tmp/urbanlist
}

# Execute in background binning all output
xbg() {
  $* &> /dev/null &
}

# Find file or directory and cd to it
cdf() {
  cd "$(dirname "$(locate -i "$*" | head -n 1)")"
}

# Find text file by content
findcontent() {
  if [ -n "$2" ]; then
    find "$1" -type f -exec grep -qI "$2" {} \; -print
  else
    find "./" -type f -exec grep -qI "$1" {} \; -print
  fi
}

# Copy and cd to dir
ccd() {
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

# Move and cd to dir
mcd() {
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

# Make then cd to dir
mkcd() {
  mkdir "$1" && cd "$1"
}

# cd to directory then ls
cdl() {
  if [ -n "$1" ]; then
    cd "$@" && ls
  else
    cd ~ && ls
  fi
}

# Reverse lines of file
rev() {
  sed -n '1!G;h;$p' $1
}

# List sizes of subdirectories
dirsizelist() {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm /tmp/list
}

# List subdirectories, largest first
dirsize() {
  dirsizelist > /tmp/outlist
  rev /tmp/outlist
}

# Save PNG of current window
snap() {
  import -frame -strip -quality 75 "$WINCAPTUREDIR/$(date +%F-%H%M%S).png"
}

# Backup file
bup() {
  cp $1 ${1}-$(date +%Y%m%d%H%M).backup
}

# Column formatted mount
cmount() {
  (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t
}

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
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo $myip

# Filesystem space (colourise later)
echo
df -h | sed -n '1p;/mapper/p'

# Fortune cookies
echo
fortune -eos computers linux
echo

