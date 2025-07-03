#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w\[\e[0m\]\$ '
S1='[\u@\h \W]\$ '
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd "$cwd"
  fi
  rm -f -- "$tmp"
}

# ============================================ FZF ======================================
if command -v fzf >/dev/null; then
  # Only run eval if fzf provides a shell extension for bash

  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
  export FZF_TMUX_OPTS="-p90%,70%"
fi

# ============================================= Aliases ================================
# Pacman & AUR Helpers
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacman-maintenance="sudo pacman -Scc"
alias pacman-update="sudo pacman -Syu"
alias yay-update="yay -Syu"

# Git Shortcuts
alias gs="git status"
alias ga="git add ."

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Power Profiles
alias power-saver='powerprofilesctl set power-saver'
alias power-performance='powerprofilesctl set performance'
alias power-balanced='powerprofilesctl set balanced'

# Tools
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'
alias cat='bat --theme=base16'
alias v='nvim'
alias ds='yazi'
alias slock='i3lock-fancy'
alias fman="compgen -c | fzf | xargs man"


eval "$(fzf --bash)"
eval "$(zoxide init bash)"

# fnm
FNM_PATH="/home/prakhar/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
[[ $- == *i* ]] && command -v krabby &>/dev/null && krabby random

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
