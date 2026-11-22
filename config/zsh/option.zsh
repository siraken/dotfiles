autoload -Uz colors && colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''

# Keep `exit` out of the history, like HISTIGNORE=exit in bash. Returning 1
# drops the line from both the history list and the history file.
zshaddhistory() {
  [[ ${1%%$'\n'} != exit ]]
}
