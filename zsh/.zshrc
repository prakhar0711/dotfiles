# ====================================================================
#  Core ZSH Configuration
# ====================================================================

# Exit if not running interactively
[[ $- != *i* ]] && return

# Initialize Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
# ====================================================================
#  Environment Variables
# ====================================================================

export EDITOR='nvim'
export VISUAL="${EDITOR}"
export BROWSER='thorium'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Enter Password : "

# Path Configuration
export GOPATH=$HOME/go
export PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/bin:$PATH:$GOPATH/bin"
export FPATH="${HOME}/eza/completions/zsh:$FPATH"

# History Configuration
export HISTFILE="${HOME}/.config/zsh/zhistory"
HISTSIZE=5000
SAVEHIST=5000
# HISTDUP=erase

# ====================================================================
#  History Options
# ====================================================================

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ====================================================================
#  ZSH Options and Features
# ====================================================================

setopt AUTOCD
setopt PROMPT_SUBST
setopt MENU_COMPLETE
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# Initialize Completion System
autoload -Uz compinit add-zsh-hook vcs_info
# for dump in ~/.config/zsh/zcompdump(N.mh+24); do
#   compinit -d ~/.config/zsh/zcompdump
# done
compinit -C -d "${HOME}/.config/zsh/zcompdump"

# ====================================================================
#  Terminal Title Functions
# ====================================================================

function xterm_title_precmd() {
  print -Pn -- '\e]2;%n@%m %~\a'
  [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec() {
  print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
  [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (ghostty*|kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
  add-zsh-hook -Uz precmd xterm_title_precmd
  add-zsh-hook -Uz preexec xterm_title_preexec
fi

# ====================================================================
#  Completion Styles
# ====================================================================

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# ====================================================================
#  Aliases
# ====================================================================

# System Maintenance
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacman-maintenance="sudo pacman -Scc"
alias paru-maintenance="sudo paru -Scc"
alias update="paru -Syu --nocombinedupgrade"
alias pacman-update='sudo pacman -Syu'
alias yay-update='yay -Syu'
alias paru-update='paru -Syu'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Power Management
alias power-saver='powerprofilesctl set power-saver'
alias power-performance='powerprofilesctl set performance'
alias power-balanced='powerprofilesctl set balanced'

# Applications
alias music="ncmpcpp"

# ====================================================================
#  Custom Functions
# ====================================================================

# Rust compilation and execution
runr() {
  rustc "$1" && ./$(basename "$1" .rs)
}

# Java compilation and execution
runj() {
  javac "$1" && java $(basename "$1" .java)
}

# Package cache handling
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
#  Plugin Configuration
# ====================================================================

plugins=(git sudo zsh-256color zsh-interactive-cd zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

# Key Bindings
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
bindkey '\e[3~' delete-char

# The prompt cursor in normal mode
# Disable the cursor style feature
ZVM_CURSOR_STYLE_ENABLED=false
ZVM_NORMAL_MODE_CURSOR=ZVM_CURSOR_BLOCK
# The prompt cursor in insert mode=ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=ZVM_CURSOR_BLOCK
# The prompt cursor in visual mode=ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=ZVM_CURSOR_BLOCK
# The prompt cursor in visual line mode=ZVM_CURSOR_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=ZVM_CURSOR_BLOCK

# ====================================================================
#  External Tools Integration
# ====================================================================

# FNM (Fast Node Manager)
FNM_PATH="/home/prakhar/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/prakhar/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# Various Tool Initializations
source $ZSH/oh-my-zsh.sh
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "  
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Console Output (if interactive)
if [[ $- == *i* ]]; then
  krabby random
fi

# File Management
alias ls='eza --icons=always --color=always -a'
alias ll='command eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'
alias cat="bat --theme=base16"
alias n="nvim"
alias ds="yazi"
alias slock="i3lock-fancy"
alias fman="compgen -c | fzf | xargs man"
alias cheat="cheat -e"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!

export PATH="/usr/lib/jvm/java-23-openjdk/bin:$PATH"
export MANPAGER='nvim +Man!'

# # fnm
# FNM_PATH="/home/prakhar/.local/share/fnm"
# if [ -d "$FNM_PATH" ]; then
#   export PATH="/home/prakhar/.local/share/fnm:$PATH"
#   eval "`fnm env`"
# fi
