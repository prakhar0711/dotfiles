# Load Antigen
source "$HOME/.antigen.zsh"
antigen use oh-my-zsh
# === Theme ===
antigen theme robbyrussell

# === Bundles (Plugins) ===
antigen bundle git
antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle Aloxaf/fzf-tab

# === Apply bundles and theme ===
antigen apply

# === Environment Variables ===
export EDITOR='nvim'
export VISUAL="$EDITOR"
export BROWSER='thorium'
export SUDO_PROMPT="Deploying root access for %u. Enter Password : "

export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH"
export FPATH="$HOME/eza/completions/zsh:$FPATH"

export MANPAGER='nvim +Man!'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# === Zsh options ===
setopt AUTOCD PROMPT_SUBST MENU_COMPLETE LIST_PACKED AUTO_LIST COMPLETE_IN_WORD

# === Completion system setup ===
autoload -Uz compinit add-zsh-hook vcs_info
compinit -C -d "$HOME/.config/zsh/zcompdump"

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# === Terminal Title Functions ===
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

# === Custom functions ===
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

# === Auto rehash on pacman cache update ===
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

# === Key bindings ===
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
bindkey '\e[3~' delete-char

# === FNM (Fast Node Manager) if installed ===
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]] && command -v fnm >/dev/null; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# === fzf initialization if installed ===
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

# === Aliases ===
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacman-maintenance="sudo pacman -Scc"
alias paru-maintenance="sudo paru -Scc"
alias update="paru -Syu --nocombinedupgrade"
alias pacman-update="sudo pacman -Syu"
alias yay-update="yay -Syu"
alias paru-update="paru -Syu"

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
alias cheat="cheat -e"

# === zoxide if installed ===
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# === atuin if installed ===
if command -v atuin >/dev/null; then
  eval "$(atuin init zsh)"
fi

# === Console output to randomize krabby if available ===
[[ $- == *i* ]] && command -v krabby &>/dev/null && krabby random

# # ====================================================================
# #  Core ZSH Configuration
# # ====================================================================
#
# [[ $- != *i* ]] && return  # Exit if not running interactively
#
# # Set theme and plugin list before sourcing Oh My Zsh
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(sudo zsh-256color zsh-interactive-cd zsh-syntax-highlighting zsh-autosuggestions zsh-completions zsh-vi-mode fzf-tab)
# # Only changing the escape key to `jk` in insert mode, we still
# # keep using the default keybindings `^[` in other modes
# ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
# # ====================================================================
# #  Environment Variables
# # ====================================================================
#
# export EDITOR='nvim'
# export VISUAL="$EDITOR"
# export BROWSER='thorium'
# export SUDO_PROMPT="Deploying root access for %u. Enter Password : "
#
# export GOPATH="$HOME/go"
# export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH"
# export FPATH="$HOME/eza/completions/zsh:$FPATH"
#
# export MANPAGER='nvim +Man!'
# export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
#
# # ====================================================================
# #  History Configuration
# # ====================================================================
#
# # export HISTFILE="$HOME/.config/zsh/zhistory"
# # HISTSIZE=5000
# # SAVEHIST=5000
# #
# # setopt appendhistory
# # setopt sharehistory
# # setopt hist_ignore_space
# # setopt hist_ignore_all_dups
# # setopt hist_save_no_dups
# # setopt hist_ignore_dups
# # setopt hist_find_no_dups
#
# # ====================================================================
# #  ZSH Options and Features
# # ====================================================================
#
# setopt AUTOCD PROMPT_SUBST MENU_COMPLETE LIST_PACKED AUTO_LIST COMPLETE_IN_WORD
#
# # ====================================================================
# #  Completion System
# # ====================================================================
#
# autoload -Uz compinit add-zsh-hook vcs_info
# compinit -C -d "$HOME/.config/zsh/zcompdump"
#
# # Completion styles
# zstyle ':completion:*' verbose true
# zstyle ':completion:*:*:*:*:*' menu select
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'
# zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
# zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
# zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'
#
# # ====================================================================
# #  Terminal Title
# # ====================================================================
#
# function xterm_title_precmd() {
#   print -Pn -- '\e]2;%n@%m %~\a'
#   [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
# }
#
# function xterm_title_preexec() {
#   print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
#   [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
# }
#
# if [[ "$TERM" == (ghostty*|kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
#   add-zsh-hook -Uz precmd xterm_title_precmd
#   add-zsh-hook -Uz preexec xterm_title_preexec
# fi
#
# # ====================================================================
# #  Custom Functions
# # ====================================================================
#
# runr() { rustc "$1" && ./$(basename "$1" .rs); }
# runj() { javac "$1" && java $(basename "$1" .java); }
#
# # Yazi + directory sync
# y() {
# 	local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
# 	yazi "$@" --cwd-file="$tmp"
# 	if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
# 		cd "$cwd"
# 	fi
# 	rm -f -- "$tmp"
# }
#
# # Auto-rehash if pacman cache updates
# zshcache_time="$(date +%s%N)"
# rehash_precmd() {
#   if [[ -a /var/cache/zsh/pacman ]]; then
#     local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
#     if (( zshcache_time < paccache_time )); then
#       rehash
#       zshcache_time="$paccache_time"
#     fi
#   fi
# }
# add-zsh-hook -Uz precmd rehash_precmd
#
# # ====================================================================
# #  Key Bindings
# # ====================================================================
#
# bindkey '\e[A' history-substring-search-up
# bindkey '\e[B' history-substring-search-down
# bindkey '\e[3~' delete-char
#
# # ====================================================================
# #  Tooling Initialization (Deferred When Possible)
# # ====================================================================
#
# # Oh My Zsh (after plugin/theme setup)
# source "$ZSH/oh-my-zsh.sh"
#
# # fnm (Fast Node Manager)
# FNM_PATH="$HOME/.local/share/fnm"
# if [[ -d "$FNM_PATH" ]] && command -v fnm >/dev/null; then
#   export PATH="$FNM_PATH:$PATH"
#   eval "$(fnm env --use-on-cd --shell zsh)"
# fi
#
# # fzf
# if command -v fzf >/dev/null; then
#   eval "$(fzf --zsh)"
#   export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
#   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#   export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
#   export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
#   export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
#   export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
#   export FZF_TMUX_OPTS="-p90%,70%"
# fi
# # ====================================================================
# #  Aliases
# # ====================================================================
#
# # System
# alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
# alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# alias pacman-maintenance="sudo pacman -Scc"
# alias paru-maintenance="sudo paru -Scc"
# alias update="paru -Syu --nocombinedupgrade"
# alias pacman-update="sudo pacman -Syu"
# alias yay-update="yay -Syu"
# alias paru-update="paru -Syu"
#
# # Navigation
# alias ..='cd ..' ...='cd ../..' .3='cd ../../..' .4='cd ../../../..' .5='cd ../../../../..'
#
# # Power
# alias power-saver='powerprofilesctl set power-saver'
# alias power-performance='powerprofilesctl set performance'
# alias power-balanced='powerprofilesctl set balanced'
#
# # Tools
# alias ls='eza --icons=always --color=always -a'
# alias ll='eza --icons=always --color=always -la'
# alias tree='eza --tree --level=2'
# alias cat='bat --theme=base16'
# alias music='ncmpcpp'
# alias v='nvim'
# alias ds='yazi'
# alias slock='i3lock-fancy'
# alias fman="compgen -c | fzf | xargs man"
# alias cheat="cheat -e"
#
#
#
# # zoxide
# if command -v zoxide >/dev/null; then
#   eval "$(zoxide init zsh)"
# fi
#
# # atuin
# if command -v atuin >/dev/null; then
#   eval "$(atuin init zsh)"
# fi
#
# # oh-my-posh (optional)
# # eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
#
# # Console output to randomize krabby (if interactive)
# [[ $- == *i* ]] && command -v krabby &>/dev/null && krabby random
#
#
# ### Added by Zinit's installer
# if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
#     print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#     command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
#     command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
#         print -P "%F{33} %F{34}Installation successful.%f%b" || \
#         print -P "%F{160} The clone has failed.%f%b"
# fi
#
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
# ### End of Zinit's installer chunk
