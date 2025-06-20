unsetopt BEEP

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit light zsh-users/zsh-autosuggestions
# zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light Aloxaf/fzf-tab
# zinit light zsh-users/zsh-completions
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    Aloxaf/fzf-tab \
    zsh-users/zsh-completions


# zinit snippet OMZL::git.zsh
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::sudo \
    OMZP::copypath


# autoload -U compinit && compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
[[ -s $zcompdump ]] && compinit -C || compinit

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias hr='hyprctl reload'

alias vpn='cd ~/dotfiles && make vpn'

alias ls="eza"
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias c='clear'
alias obsi="obsidian --ozone-platform=wayland"
alias code="code --ozone-platform=wayland"
alias ya="yandex-browser --ozone-platform=wayland"

alias nrs="sudo nixos-rebuild switch --flake /home/drama/dotfiles#drama --impure"
alias gnu-stow="stow -v -t ~ -d ~/dotfiles ."

alias fast='kitten icat -n --align left ~/dotfiles/images/frieren_5_6_3.gif | fastfetch --raw -'
alias zshrc='nvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias vinix='sudo nvim /home/drama/dotfiles/configuration.nix'
alias icat="kitten icat"
alias lock="~/.config/scripts/lockscreen.sh"
alias mur="appimage-run ~/Murglar.appimage"
cpfile() {
  wl-copy < "$1"
}

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
