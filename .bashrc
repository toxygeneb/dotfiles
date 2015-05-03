#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set environment variables
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Export environment variables
export EDITOR=/usr/bin/vim

# Set bash options
shopt -s histappend
shopt -s checkwinsize
shopt -s mailwarn

# Define aliases
alias ls='ls --color=auto'

# Customise prompt
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
#PS1='[\u@\h \W]\$ '
PS1='[\[\e[0;32m\]\u@\h\[\e[0;36m\] \W\[\e[0m\]]\$ '

