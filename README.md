# dotmac

macOS dotfiles. too many specific things so I decided to split it out. oh well. not supported.

```
$ git clone --bare https://github.com/nicholastay/dotmac.git ~/.dotmac.git
$ git --git-dir=$HOME/.dotmac.git/ --work-tree=$HOME checkout

# Install brew packages via bundle
$ brew bundle --file=$HOME/.local/ntay/Brewfile

# Load iTerm 2 configs
$ defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2-prefs"
$ defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Any dotfiles-related git operations
$ d ...
```
