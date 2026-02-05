#!/bin/bash

DEBUG=1

OS=$(uname)
SCRIPT_NAME=$(basename $0)
SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)

if [ $OS != 'Darwin' ]; then
  echo "This script only runs on macOS"
  exit
fi

if [ $DEBUG -ne 1 ] && [ $SCRIPT_DIR != "/usr/local/bin" ]; then
  sudo mv $SCRIPT_DIR/$SCRIPT_NAME /usr/local/bin
  sudo chmod +x /usr/local/bin/$SCRIPT_NAME
fi

COMMAND=$1

case $1 in
audio)
  sudo launchctl stop com.apple.audio.coreaudiod
  sudo launchctl start com.apple.audio.coreaudiod
  ;;
bluetooth)
  sudo launchctl stop com.apple.bluetoothd
  sudo launchctl start com.apple.bluetoothd
  ;;
dns)
  # TODO: implement
  ;;
*)
  echo "Unexpected command."
  ;;
esac
