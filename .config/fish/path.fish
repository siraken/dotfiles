##################################################
# > Path
##################################################

set -gx SSH_AUTH_SOCK "$HOME/.1password/agent.sock"
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx GOPATH "$HOME/go"
set -gx PNPM_HOME "$HOME/.pnpm"
set -gx MODULAR_HOME "$HOME/.modular"
set -gx BUN_INSTALL "$HOME/.bun"

set -gx PATH $PATH "/opt/homebrew/opt/openssl@3/bin" # Use openssl installed by homebrew
set -gx PATH $PATH bin
set -gx PATH $PATH "$HOME/bin"
set -gx PATH $PATH "$HOME/.local/bin"
set -gx PATH $PATH "$HOME/.progate/bin"
set -gx PATH $PATH "$HOME/Library/Application Support/Coursier/bin"
set -gx PATH $PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
set -gx PATH $PATH "$HOME/Library/Android/sdk/platform-tools"
set -gx PATH $PATH "$HOME/.pub-cache/bin"
set -gx PATH $PATH "$HOME/Developer/flutter/bin"
set -gx PATH $PATH "$HOME/.composer/vendor/bin"
set -gx PATH $PATH "$HOME/.deno/bin"
set -gx PATH $PATH "$HOME/.cargo/bin"
set -gx PATH $PATH "$HOME/.rye/shims"
set -gx PATH $PATH "$PNPM_HOME"
set -gx PATH $PATH "$VOLTA_HOME/bin"
set -gx PATH $PATH "$GOPATH/bin"
set -gx PATH $PATH "$BUN_INSTALL/bin"
set -gx PATH $PATH /opt/homebrew/sbin
set -gx PATH $PATH /opt/homebrew/bin

if test -f $HOME/Developer/google-cloud-sdk/path.fish.inc
    source $HOME/Developer/google-cloud-sdk/path.fish.inc
end

command -q rbenv; and status --is-interactive; and rbenv init - fish | source
command -q fuck; and status --is-interactive; and thefuck --alias | source
command -q zoxide; and status --is-interactive; and zoxide init fish | source
# command -q pyenv; and status --is-interactive; and pyenv init - | source
