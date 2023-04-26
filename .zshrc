# Nick's light .zshrc

# Setup the prompt (PS1)
PROMPT='%F{015}%n%f%F{243}@%f%F{176}%m%f%F{243}:%f%(5~|%-1~/../%3~|%4~)%F{68}${vcs_info_msg_0_}%f » '

# History
HISTFILE="$HOME/.local/share/zsh_history"
HISTSIZE=500000
SAVEHIST=500000

# Some misc options
setopt auto_cd
#setopt share_history
setopt menu_complete
setopt cdable_vars
# Automatically push dirs to stack so we can quickly flip between dirs
setopt auto_pushd
# For above, minus should mean reverse (at least to me?)
setopt pushd_minus
# Don't auto tab complete fill
setopt nomenucomplete
# For prompt vars
setopt prompt_subst

# No history duplicates
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Save history immediately rather than on exit
setopt INC_APPEND_HISTORY

# Use vim keys
bindkey -v
KEYTIMEOUT=1

# Vim key fixes
# Backspace in viins
bindkey -v '^?' backward-delete-char
# Ctrl-r
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
# Delete
bindkey '^[[3~' delete-char # xterm
bindkey '^[[P' delete-char # st
# Home/End in vicmd
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line # xterm
bindkey '^[[4~' end-of-line # st

# Use beam cursor
# Code 6 for static (not blinking), also for all new prompts, do this too
_beam_cursor() { echo -ne '\e[6 q' ;}
precmd_functions+=(_beam_cursor)

# Update correct cursors for zsh vi editing (from luke's)
# Except use 2 & 6 for statics
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		 [[ $1 = 'block' ]]; then
		echo -ne '\e[2 q'

	elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ ${KEYMAP} = '' ]] ||
			 [[ $1 = 'beam' ]]; then
		echo -ne '\e[6 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[6 q"
}
zle -N zle-line-init

# Dynamic xtitle
# https://wiki.archlinux.org/index.php/Zsh#xterm_title
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m:%~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-}:\005{B}%~\005{-}\e\\'
}
function xterm_title_preexec () {
	print -Pn -- '\e]2;' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-}:\005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}
if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*|st*|alacritty*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

autoload -Uz add-zsh-hook vcs_info

# Autosuggestion plugin
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
bindkey '^K' autosuggest-execute

# FZF History plugin
source $HOME/.local/share/zsh/plugin/zsh-fzf-history-search/zsh-fzf-history-search.zsh 2>/dev/null

# VCS
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'


# Syntax highlighting plugin
# Must be loaded last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null && { \
	# Add some color changes from the default green (to lighter)
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=114,underline
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=114,underline
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=114
}


# Completion via brew
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Other completions
# Speed up compinit by only checking once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C


# Load our common aliases
source $HOME/.config/aliasrc
