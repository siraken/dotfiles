BASH_DIR="${HOME}/.config/bash"

if [ -d $BASH_DIR ] && [ -r $BASH_DIR ] && [ -x $BASH_DIR ]; then
  for file in ${BASH_DIR}/*.sh; do
    [ -r $file ] && source $file
  done
fi
