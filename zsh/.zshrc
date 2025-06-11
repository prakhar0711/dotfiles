# ====================================================================
#  Core ZSH Configuration
# ====================================================================

[[ $- != *i* ]] && return  # Exit if not running interactively
# only for bash like prompt

#loading antidote
source /home/prakhar/.antidote/antidote.zsh
# antidote load

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=(/home/prakhar/.antidote/functions/ $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

autoload -U colors && colors
export PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}$ "

# PS1="%F{#57d9a4}%n@%m%f:%F{cyan}%~%f$ "
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
# ====================================================================
#  Environment Variables
# ====================================================================

export EDITOR='nvim'
export VISUAL="$EDITOR"
export BROWSER='firefox'
export SUDO_PROMPT="Deploying root access for %u. Enter Password : "

export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH"
export FPATH="$HOME/eza/completions/zsh:$FPATH"

export MANPAGER='nvim +Man!'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# ====================================================================
#  Completion System
# ====================================================================

autoload -Uz compinit add-zsh-hook vcs_info
compinit -C -d "$HOME/.config/zsh/zcompdump"

# ====================================================================
#  Custom Functions
# ====================================================================

runr() { rustc "$1" && ./$(basename "$1" .rs); }
runj() { javac "$1" && java $(basename "$1" .java); }

# Yazi + directory sync
y() {
	local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}

# Auto-rehash if pacman cache updates
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

# ====================================================================
#  Tooling Initialization (Deferred When Possible)
# ====================================================================

# Oh My Zsh (after plugin/theme setup)
# source "$ZSH/oh-my-zsh.sh"

# fnm (Fast Node Manager)
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]] && command -v fnm >/dev/null; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# fzf
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
# ====================================================================
#  Aliases
# ====================================================================

# System
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacman-maintenance="sudo pacman -Scc"
alias paru-maintenance="sudo paru -Scc"
alias update="paru -Syu --nocombinedupgrade"
alias pacman-update="sudo pacman -Syu"
alias yay-update="yay -Syu"
alias paru-update="paru -Syu"

# Navigation
alias ..='cd ..' ...='cd ../..' .3='cd ../../..' .4='cd ../../../..' .5='cd ../../../../..'

# Power
alias power-saver='powerprofilesctl set power-saver'
alias power-performance='powerprofilesctl set performance'
alias power-balanced='powerprofilesctl set balanced'

# Tools
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'
alias cat='bat --theme=base16' alias music='ncmpcpp'
alias v='nvim'
alias ds='yazi'
alias slock='i3lock-fancy'
alias fman="compgen -c | fzf | xargs man"
alias cheat="cheat -e"

# zoxide
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# atuin
if command -v atuin >/dev/null; then
  eval "$(atuin init zsh)"
fi


# Console output to randomize krabby (if interactive)
[[ $- == *i* ]] && command -v krabby &>/dev/null && krabby random

eval "$(fnm env --use-on-cd --shell zsh)"
. "$HOME/.atuin/bin/env"
