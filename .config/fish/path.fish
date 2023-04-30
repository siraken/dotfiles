##################################################
# > Path
##################################################
set -gx EDITOR nvim

set -g GOPATH $HOME/go
set -g VOLTA_HOME $HOME/.volta
set -g JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH

# Use homebrew-installed openssl
set -gx PATH "/opt/homebrew/opt/openssl@3/bin" $PATH

set -gx PATH bin $PATH
set -gx PATH "$GOPATH/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$HOME/.composer/vendor/bin" $PATH
set -gx PATH "$HOME/Developer/flutter/bin" $PATH
set -gx PATH "$HOME/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.progate/bin" $PATH

# TODO: probably need to be added if statement
set -gx PATH "$HOME/Library/Android/sdk/platform-tools" $PATH
set -gx PATH "$HOME/.deno/bin" $PATH
set -gx PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $PATH

test -e "$HOME/.phpbrew/phpbrew.fish"; and source "$HOME/.phpbrew/phpbrew.fish"

status --is-interactive; and rbenv init - fish | source
status --is-interactive; and pyenv init - | source
status --is-interactive; and thefuck --alias | source

