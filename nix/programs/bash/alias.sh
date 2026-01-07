# Conditional aliases (require command existence check)

if type bat > /dev/null; then
  alias cat="bat"
fi

if type eza > /dev/null; then
  alias ll="eza -l -g --icons"
  alias lla="ll -a"
fi
