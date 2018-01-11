#
# ~/.bash_profile
#

if [[ ${TERM} != "tmux-256color"  ]]; then
  echo
  dmesg | grep microcode
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
