ZSH_DIR="${HOME}/.config/zsh"

if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
  source $ZSH_DIR/option.zsh
  source $ZSH_DIR/completion.zsh
  source $ZSH_DIR/alias.zsh
fi

