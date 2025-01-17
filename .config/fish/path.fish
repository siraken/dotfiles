##################################################
# > Path
##################################################

set -gx PHP_INI_SCAN_DIR "$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
set -gx SSH_AUTH_SOCK "$HOME/.1password/agent.sock"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx GOPATH "$HOME/go"
set -gx PNPM_HOME "$HOME/.pnpm"
set -gx MODULAR_HOME "$HOME/.modular"
set -gx BUN_INSTALL "$HOME/.bun"
set -gx JAVA_HOME "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
#set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
#set -gx JAVA_HOME "/opt/homebrew/opt/openjdk@23/libexec/openjdk.jdk/Contents/Home"
#set -gx JAVA_HOME "/opt/homebrew/opt/openjdk@22/libexec/openjdk.jdk/Contents/Home"

set -gx PATH "/opt/homebrew/opt/openssl@3/bin" $PATH # Use openssl installed by homebrew
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH bin $PATH
set -gx PATH "$HOME/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.progate/bin" $PATH
set -gx PATH "$HOME/.slack/bin" $PATH
set -gx PATH "$HOME/Library/Application Support/Coursier/bin" $PATH
set -gx PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "$HOME/Library/Android/sdk/platform-tools" $PATH
set -gx PATH "$HOME/.config/herd-lite/bin" $PATH
set -gx PATH "$HOME/.pub-cache/bin" $PATH
set -gx PATH "$HOME/Developer/flutter/bin" $PATH
set -gx PATH "$HOME/.composer/vendor/bin" $PATH
set -gx PATH "$HOME/.deno/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.rye/shims" $PATH
set -gx PATH "$PNPM_HOME" $PATH
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$GOPATH/bin" $PATH
set -gx PATH "$BUN_INSTALL/bin" $PATH

if test -f $HOME/Developer/google-cloud-sdk/path.fish.inc
    source $HOME/Developer/google-cloud-sdk/path.fish.inc
end

command -q rbenv; and status --is-interactive; and rbenv init - fish | source
command -q fuck; and status --is-interactive; and thefuck --alias | source
command -q zoxide; and status --is-interactive; and zoxide init fish | source
# command -q pyenv; and status --is-interactive; and pyenv init - | source
