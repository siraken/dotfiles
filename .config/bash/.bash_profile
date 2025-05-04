BASH_DIR="${HOME}/.config/bash"
HISTCONTROL=erasedups

if [ -d $BASH_DIR ] && [ -r $BASH_DIR ] && [ -x $BASH_DIR ]; then
  source $BASH_DIR/variable.sh
  source $BASH_DIR/path.sh
  source $BASH_DIR/function.sh
  source $BASH_DIR/alias.sh
  source $BASH_DIR/eval.sh
  source $BASH_DIR/messages.sh
fi
