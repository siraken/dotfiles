##################################################
# Alias
##################################################
# alias ls="ls -p -G"
# alias la "ls -A"
# alias ll="ls -l"
# alias lla="ls -A"
alias g='git'
alias gs='git status'
alias lzg="lazygit"
alias lzd="lazydocker"
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias posh="pwsh"
alias cls='clear'
alias md="mkdir"
alias e="emacs"
alias lvim="/usr/bin/vim"
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
alias -g G='| grep'
alias -g L='| less'
alias -g F='| fzf'
alias -g C='| pbcopy'
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

