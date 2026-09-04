# Conditional aliases (require command existence check)

if type bat >/dev/null 2>&1; then
  alias cat="bat"
fi

if type eza >/dev/null 2>&1; then
  alias ll="eza -l -g --icons --sort=type"
  alias lla="ll -a"
fi
