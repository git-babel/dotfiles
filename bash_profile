# shell color setting
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# copied by https://github.com/yous/dotfiles; prompt setting
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  *color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  if [[ "$TERM" = *"256color" ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;109m\]\u\[\033[00m\] \[\033[38;5;143m\]\w\[\033[00m\] \$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[00m\] \[\033[01;32m\]\w\[\033[00m\] \$ '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac
