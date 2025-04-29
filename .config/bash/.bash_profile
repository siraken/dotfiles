BASH_DIR="${HOME}/.config/bash"

if [ -d $BASH_DIR ] && [ -r $BASH_DIR ] && [ -x $BASH_DIR ]; then
  source $BASH_DIR/01_variable.sh
  source $BASH_DIR/02_path.sh
  source $BASH_DIR/03_function.sh
  source $BASH_DIR/04_alias.sh
  source $BASH_DIR/05_eval.sh
  source $BASH_DIR/messages.sh
fi
