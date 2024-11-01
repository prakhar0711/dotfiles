# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ====================================================================
#  Shell Configuration and Environment Setup
# ====================================================================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ====================================================================
#  Environment Variables
# ====================================================================
export VISUAL="${EDITOR}"
export EDITOR='geany'
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Enter Password : "

# Add local bin to PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

export HISTFILE="${HOME}/.config/zsh/zhistory"
export GOPATH=$HOME/go
export PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/bin:$PATH:$GOPATH/bin"
export FPATH="${HOME}/eza/completions/zsh:$FPATH"

# ====================================================================
#  ZSH Configuration & Plugins
# ====================================================================

# Initialize Zsh completion
autoload -Uz compinit add-zsh-hook vcs_info
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done
compinit -C -d "${HOME}/.config/zsh/zcompdump"

# Hooks for title changing in terminals
function xterm_title_precmd() {
  print -Pn -- '\e]2;%n@%m %~\a'
  [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec() {
  print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
  [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
  add-zsh-hook -Uz precmd xterm_title_precmd
  add-zsh-hook -Uz preexec xterm_title_preexec
fi

# ====================================================================
#  Aliases and Shortcuts
# ====================================================================

# General Aliases
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias maintenance="sudo pacman -Scc"
alias update="paru -Syu --nocombinedupgrade"
alias music="ncmpcpp"
alias cat="bat --theme=base16"
alias n="nvim"

# System Update Aliases
alias pacman-update='sudo pacman -Syu'
alias yay-update='yay -Syu'
alias paru-update='paru -Syu'

# Git Aliases
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# Power Profile Aliases
alias power-saver='powerprofilesctl set power-saver'
alias power-performance='powerprofilesctl set performance'
alias power-balanced='powerprofilesctl set balanced'


# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Rust run shortcut
runc() {
  rustc "$1" && ./$(basename "$1" .rs)
}
runj() {
  javac "$1" && java $(basename "$1" .java)
}

# ZSH Plugins
plugins=(git sudo zsh-256color zsh-interactive-cd zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char

# ====================================================================
#  Zsh History Settings
# ====================================================================

HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ====================================================================
#  ZSH Options
# ====================================================================

setopt AUTOCD
setopt PROMPT_SUBST
setopt MENU_COMPLETE
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# On-demand rehash
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

# Initialize VCS Info
precmd() { vcs_info }

# ====================================================================
#  Completion and Styles
# ====================================================================

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  '+r:|[._-]=* r:|=*' \
  '+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# Completion with dots
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# ====================================================================
#  Miscellaneous Setup
# ====================================================================

# Console Output Commands (move below Powerlevel10k setup)
if [[ $- == *i* ]]; then
  pokemon-colorscripts --no-title -r 1,3,6
fi


# ====================================================================
#  Oh My Zsh Initialization
# ====================================================================

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# Load fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Filesystem Aliases
alias ls='eza --icons=always --color=always -a'
alias ll='command eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'
# FNM (Fast Node Manager) setup
FNM_PATH="/home/prakhar/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/prakhar/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
eval "$(fnm env --use-on-cd --shell zsh)"
# Load Zoxide and Atuin
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"


