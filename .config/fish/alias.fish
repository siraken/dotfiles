##################################################
# > Alias
##################################################
alias g="git"
alias gs="git status"
alias lzg="lazygit"
alias lzd="lazydocker"
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias posh="pwsh"
alias cls="clear"
alias md="mkdir"
alias e="emacs"
alias lvim="/usr/bin/vim"
alias vim="nvim"
alias bim="vim"
alias nbim="nvim"
alias nf="neofetch"
alias datetime="date '+%Y-%m-%d %H:%H:%S'"
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias mrm="touch README.md"
alias rb="ruby"
alias py="python"
alias n="node"

if type -q exa
  alias ls "ll"
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
  alias llt='ll --tree'
  alias llta='llt -a'
end

