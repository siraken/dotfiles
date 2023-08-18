##################################################
# > Path
##################################################
set -gx EDITOR nvim

set -gx SSH_AUTH_SOCK "$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx GOPATH $HOME/go

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /opt/homebrew/opt/openssl@3/bin $PATH # Use openssl installed by homebrew
set -gx PATH bin $PATH
set -gx PATH "$GOPATH/bin" $PATH
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$HOME/.rye/shims" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.deno/bin" $PATH
set -gx PATH "$HOME/.composer/vendor/bin" $PATH
set -gx PATH "$HOME/Developer/flutter/bin" $PATH
set -gx PATH "$HOME/.pub-cache/bin" $PATH
set -gx PATH "$HOME/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.progate/bin" $PATH
set -gx PATH "$HOME/Library/Android/sdk/platform-tools" $PATH
set -gx PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "$HOME/Library/Application Support/Coursier/bin" $PATH

test -e "$HOME/.phpbrew/phpbrew.fish"; and source "$HOME/.phpbrew/phpbrew.fish"
# FIXME: rye does not work on fish shell
# test -e "$HOME/.rye/env"; and source "$HOME/.rye/env"

command -q rbenv; and status --is-interactive; and rbenv init - fish | source
command -q fuck; and status --is-interactive; and thefuck --alias | source
command -q zoxide; and status --is-interactive; and zoxide init fish | source
# command -q pyenv; and status --is-interactive; and pyenv init - | source
