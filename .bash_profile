#
# ~/.bash_profile
#

if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
  echo
  dmesg | grep microcode
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
