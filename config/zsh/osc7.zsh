# Report the working directory to the terminal (OSC 7) so new tabs / splits can
# open in the same directory. WezTerm on Windows needs this to see the Linux
# cwd of a WSL pane; terminals that do not understand it ignore the sequence.
# The zsh counterpart of config/bash/osc7.sh.

# Ghostty and Kitty already emit OSC 7 via their built-in shell integrations.
if [[ -z "${GHOSTTY_RESOURCES_DIR:-}" && -z "${KITTY_WINDOW_ID:-}" ]]; then
  typeset -g __osc7_last_pwd="" __osc7_last_url=""

  __osc7_cwd() {
    emulate -L zsh
    if [[ $PWD != "$__osc7_last_pwd" ]]; then
      local LC_ALL=C
      # Not `path`: in zsh that is the array tied to PATH.
      local encoded="" char i
      for ((i = 1; i <= ${#PWD}; i++)); do
        char=${PWD[i]}
        case $char in
        [-/:_.~[:alnum:]]) encoded+=$char ;;
        *) printf -v char '%%%02X' "'$char" && encoded+=$char ;;
        esac
      done
      __osc7_last_pwd=$PWD
      __osc7_last_url="file://${HOST}${encoded}"
    fi
    # Always emit (even on cache hit) so returning from SSH/subshells restores
    # the terminal cwd. \e\\ is the string terminator (ST), not an escaped quote.
    printf '\e]7;%s\e\\' "$__osc7_last_url"
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd __osc7_cwd
fi
