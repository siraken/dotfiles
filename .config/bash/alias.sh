alias cd="z"
# alias ls="ls -p -G"
# alias la "ls -A"
# alias ll="ls -l"
# alias lla="ls -A"
alias g='git'
alias gs='git status'
alias lzg="lazygit"
alias lzd="lazydocker"
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias cls='clear'
alias md="mkdir"
alias e="emacs"
alias ee="emacsclient -nw"
alias emacsd="emacs --daemon"
alias vim='nvim'
alias datetime="date '+%Y-%m-%d %H:%H:%S'"
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias dep="[ -f dep ] && sh dep || sh vendor/bin/dep"
alias mrm="touch README.md"
alias rb="ruby"
alias py="python"
alias n="node"
alias gopj="cd $GOPATH/src/github.com/"
alias rustrepl="evcxr"
alias tf="terraform"
alias spt="spotify_player"
alias act="act --container-architecture linux/amd64"
alias wez="wezterm"
alias cc="claude"
alias ccd="claude --dangerously-skip-permissions"
alias ccu="bunx ccusage@latest"
alias cculv="bunx ccusage@latest blocks --live"
# Aliases for macOS
alias ii="open"
alias mamp-htdocs="cd /Applications/MAMP/htdocs"
alias lisp-server='sbcl --load \
  $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp'

if type bat > /dev/null; then
  alias cat="bat"
fi

if type eza > /dev/null; then
  alias ll="eza -l -g --icons"
  alias lla="ll -a"
fi

