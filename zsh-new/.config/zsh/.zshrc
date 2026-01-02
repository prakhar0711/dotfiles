source $ZDOTDIR/zshrc

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# fnm
FNM_PATH="/home/prakhar/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
