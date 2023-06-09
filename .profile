# Nick's light .profile
# Quite a lot of exports cut down, as we don't include the X programs ones here,
# just enough for cli

export PATH=$HOME/.local/bin:$PATH

# PATH additions for brew
[ -d "/opt/homebrew" ] && eval $(/opt/homebrew/bin/brew shellenv)
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

# Programs
command -v nvim >/dev/null \
	&& export EDITOR="nvim" \
	|| export EDITOR="vim"
export VISUAL="$EDITOR"
export FILE="ranger"

# Home dot cleanup
export LESSHISTFILE="-"

# Tool config
export FZF_DEFAULT_OPTS="--layout=reverse --height 50%"
