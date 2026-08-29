# Set history parameters early
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# Source main configuration
[[ -f "$ZDOTDIR/zshrc" ]] && source "$ZDOTDIR/zshrc"
