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

# FNM (Fast Node Manager) setup
FNM_PATH="/home/prakhar/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/prakhar/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
eval "$(fnm env --use-on-cd --shell zsh)"

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

# Compiling C and Rust Programs
run() {
  if [ -z "$1" ]; then
    echo "Usage: run <filename>"
    return 1
  fi
  make "$1" && ./"$1"
}

runc() {
  rustc "$1" && ./$(basename "$1" .rs)
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

# ====================================================================
#  Prompt Setup and VCS Information
# ====================================================================

function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{cyan}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}

PS1='%B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

# Initialize VCS Info
precmd () { vcs_info }

# Zsh Completion and Styles
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

# Change terminal titles for supported terminals
# Loaded during interactive sessions
pokemon-colorscripts --no-title -r 1,3,6

# Source Oh-My-Zsh and Powerlevel10k
ZSH=/usr/share/oh-my-zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Load Zoxide and Atuin
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Miscellaneous

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}
# Filesystem Aliases
alias ls='eza --icons=always --color=always -a'
alias ll='command eza --icons=always --color=always -la'
alias tree='eza --tree --level=2'

