# Report the working directory to the terminal (OSC 7) so new tabs / splits can
# open in the same directory. WezTerm on Windows needs this to see the Linux
# cwd of a WSL pane; terminals that do not understand it ignore the sequence.

__osc7_cwd() {
  local LC_ALL=C
  local path="" char i
  for ((i = 0; i < ${#PWD}; i++)); do
    char=${PWD:i:1}
    case $char in
    [-/:_.~[:alnum:]]) path+=$char ;;
    *) printf -v char '%%%02X' "'$char" && path+=$char ;;
    esac
  done
  # \e\\ is the string terminator (ST), not an escaped quote
  # shellcheck disable=SC1003
  printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$path"
}

# bash-preexec (atuin) absorbs PROMPT_COMMAND into precmd_functions on the first
# prompt, so appending works whether it is loaded before or after this file.
if [[ " ${PROMPT_COMMAND[*]} " == *__osc7_cwd* ]]; then
  :
elif [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
  PROMPT_COMMAND+=(__osc7_cwd)
else
  # Only reached when PROMPT_COMMAND is a plain string (checked above)
  # shellcheck disable=SC2128,SC2178
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__osc7_cwd"
fi
