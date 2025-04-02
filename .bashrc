########################################
# Author: Martin Murin
#
########################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

########################################
### BASH HISTORY
########################################
export HISTSIZE=-1                              # no limit on number of commands
export HISTFILESIZE=2000000                     # extend the limit on history file size
export HISTCONTROL=ignoreboth                   # remove duplicates and lines starting with space
shopt -s histappend     # append to the history file rather than overwriting it
shopt -s cmdhist        # save multi-line commands in history as single line


########################################
### COLORS AND APPEARANCE
########################################
shopt -s checkwinsize   # checks term size when bash regains control

# set variable identifying the chroot environment (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# if this is an xterm set the terminal title to user@host:dir
case "$TERM" in
xterm*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
    ;;
*)
    ;;
esac

# activate coloring of the prompt line
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# we have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # set primary shell prompt: bold purple user@host: bold blue working directory $
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


########################################
### BEHAVIOR
########################################
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrect minor misspelling in cd
shopt -s globstar       # pattern "**"  matches all files and directories recursively
shopt -s dotglob        # include .filenames in the results of expansion

# enable FZF
export PATH="$HOME/.fzf/bin:$PATH"

# load fzf key bindings (Ctrl+R, Ctrl+T and Alt+C)
[ -f ~/.fzf/shell/key-bindings.bash ] && source ~/.fzf/shell/key-bindings.bash

# rebind up/down arrows for history search in vi mode (after loading fzf key-bindings)
bind -m vi-insert '"\e[A": history-search-backward'
bind -m vi-insert '"\e[B": history-search-forward'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


########################################
### VIM MODE
########################################
set -o vi                               # enable vim keybindings
export VISUAL=vim                       # set vim as default full-screen editor
export EDITOR="$VISUAL"                 # set vim for non-interactive editing
export MANPAGER="vim -M +MANPAGER -"    # use vim to view man pages

bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'


########################################
### ALIASES
########################################
# load from separate alias file if exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# adding flags
alias df='df -h'        # human-readable sizes
alias free='free -m'    # show sizes in MB

# git
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gl='git log --oneline'
alias gb='git checkout -b'
alias gd='git diff'

# git bare repo tracking dotfiles
alias dotgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# notification for long running commands, usage: "sleep 10; alert"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


########################################
### ARCHIVE EXTRACTION
########################################
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


########################################
### CONDA
########################################
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/martin/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/martin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/martin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/martin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
