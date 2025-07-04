# Core Zsh
[[ $- != *i* ]] && return
autoload -Uz compinit add-zsh-hook vcs_info
compinit -C -d "$HOME/.config/zsh/zcompdump"
autoload -U colors && colors

PROMPT='%F{green}%n@%m %F{blue}%~%f $ '

# Plugin: zsh-autosuggestions
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/plugins/zsh-256color/zsh-256color.plugin.zsh
source ~/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment
export EDITOR='nvim'
export VISUAL="$EDITOR"
export BROWSER='firefox'
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH"
export FPATH="$HOME/eza/completions/zsh:$FPATH"
export MANPAGER='nvim +Man!'
export SUDO_PROMPT="Deploying root access for %u. Enter Password : "

# Custom Functions
runr() { rustc "$1" && ./$(basename "$1" .rs); }
runj() { javac "$1" && java $(basename "$1" .java); }
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd "$cwd"
  fi
  rm -f -- "$tmp"
}

# Auto-rehash for pacman cache
zshcache_time="$(date +%s%N)"
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# Tools
if command -v fzf >/dev/null; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
  export FZF_TMUX_OPTS="-p90%,70%"
fi



# Aliases
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacman-maintenance="sudo pacman -Scc"
alias pacman-update="sudo pacman -Syu"
alias yay-update="yay -Syu"
alias gs="git status"
alias ga="git add ."
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias power-saver='powerprofilesctl set power-saver'
alias power-performance='powerprofilesctl set performance'
alias power-balanced='powerprofilesctl set balanced'
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'
alias cat='bat --theme=base16'
alias music='ncmpcpp'
alias v='nvim'
alias ds='yazi'
alias slock='i3lock-fancy'
alias fman="compgen -c | fzf | xargs man"

# fnm
if command -v fnm >/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

if command -v atuin >/dev/null; then
  eval "$(atuin init zsh)"
fi

# zoxide
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# krabby splash
[[ $- == *i* ]] && command -v krabby &>/dev/null && krabby random

. "$HOME/.atuin/bin/env"
