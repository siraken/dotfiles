# Report the working directory to the terminal (OSC 7) so new tabs / splits can
# open in the same directory. WezTerm on Windows needs this to see the Linux
# cwd of a WSL pane; terminals that do not understand it ignore the sequence.

# Ghostty and Kitty already emit OSC 7 via their built-in shell integrations.
if [[ -z "${GHOSTTY_RESOURCES_DIR:-}" && -z "${KITTY_WINDOW_ID:-}" ]]; then
  __osc7_last_pwd=""
  __osc7_last_url=""

  __osc7_cwd() {
    if [[ "$PWD" != "$__osc7_last_pwd" ]]; then
      local LC_ALL=C
      local encoded="" char i
      for ((i = 0; i < ${#PWD}; i++)); do
        char=${PWD:i:1}
        case $char in
        [-/:_.~[:alnum:]]) encoded+=$char ;;
        *) printf -v char '%%%02X' "'$char" && encoded+=$char ;;
        esac
      done
      __osc7_last_pwd=$PWD
      __osc7_last_url="file://${HOSTNAME}${encoded}"
    fi
    # Always emit (even on cache hit) so returning from SSH/subshells restores
    # the terminal cwd. \e\\ is the string terminator (ST), not an escaped quote.
    # shellcheck disable=SC1003
    printf '\e]7;%s\e\\' "$__osc7_last_url"
  }

  # bash-preexec (atuin) absorbs PROMPT_COMMAND into precmd_functions on the first
  # prompt, so appending works whether it is loaded before or after this file.
  if [[ " ${PROMPT_COMMAND[*]:-} " == *__osc7_cwd* ]]; then
    :
  elif [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
    PROMPT_COMMAND+=(__osc7_cwd)
  else
    # Only reached when PROMPT_COMMAND is a plain string (checked above)
    # shellcheck disable=SC2128,SC2178
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__osc7_cwd"
  fi
fi
