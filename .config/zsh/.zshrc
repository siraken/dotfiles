ZSH_DIR="${HOME}/.config/zsh"

if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
  for file in ${ZSH_DIR}/*.zsh; do
    [ -r $file ] && source $file
  done
fi

# ---------------
#   Aliases
# ---------------
alias -g G='| grep'
alias -g L='| less'
alias -g F='| fzf'
alias -g C='| pbcopy'
