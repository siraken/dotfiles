##################################################
# Option
##################################################
bindkey -e

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt list_packed
setopt correct
setopt auto_cd

autoload -Uz colors && colors
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''

