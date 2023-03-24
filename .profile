# Nick's light .profile
# Quite a lot of exports cut down, as we don't include the X programs ones here,
# just enough for cli

export PATH=$PATH:$HOME/.local/bin

# PATH additions for brew
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"

# Programs
command -v nvim >/dev/null \
	&& export EDITOR="nvim" \
	|| export EDITOR="vim"
export VISUAL="$EDITOR"
export FILE="ranger"

# Home dot cleanup
export LESSHISTFILE="-"

# Tool config
export FZF_DEFAULT_OPTS="--layout=reverse --height 85%"
