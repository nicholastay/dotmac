# Nick's light .profile
# Quite a lot of exports cut down, as we don't include the X programs ones here,
# just enough for cli

export PATH=$PATH:$HOME/.local/bin

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

# macOS
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="$HOME/.pyenv/bin:/opt/homebrew/opt/openjdk/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
