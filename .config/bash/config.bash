# Environment variables
export VOLTA_HOME="$HOME/.volta"
export AWS_PROFILE="default"

# Path
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Config
export CLICOLOR=true

. "$HOME/.cargo/env"
