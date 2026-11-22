# Report the working directory to the terminal (OSC 7) so new tabs / splits can
# open in the same directory. WezTerm on Windows needs this to see the Linux
# cwd of a WSL pane; terminals that do not understand it ignore the sequence.
# The zsh counterpart of config/bash/osc7.sh.

__osc7_cwd() {
  emulate -L zsh
  local LC_ALL=C
  # Not `path`: in zsh that is the array tied to PATH.
  local url="" char i
  for ((i = 1; i <= ${#PWD}; i++)); do
    char=${PWD[i]}
    case $char in
    [-/:_.~[:alnum:]]) url+=$char ;;
    *) printf -v char '%%%02X' "'$char" && url+=$char ;;
    esac
  done
  # \e\\ is the string terminator (ST), not an escaped quote
  printf '\e]7;file://%s%s\e\\' "$HOST" "$url"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd __osc7_cwd
