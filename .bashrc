# Nick's light .bashrc
# Basically the same as the full version (light already)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Our prompt (user@computer: >>)
PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

[ ! -z "$SSH_CLIENT" ] && PS1="(SSH) $PS1"

export HISTFILE="$HOME/.local/share/bash_history"

# cd by name only is ok
shopt -s autocd 2>/dev/null

# Load our aliases
[ -f $HOME/.config/aliasrc ] && . $HOME/.config/aliasrc
