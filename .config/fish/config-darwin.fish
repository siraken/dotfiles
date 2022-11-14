##################################################
# ==> Aliases
##################################################
if type -q exa
  alias ls "ll"
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
  alias llt='ll --tree'
  alias llta='llt -a'
end

alias ii="open"
alias mamp-htdocs="cd /Applications/MAMP/htdocs"
alias lisp-server='sbcl --load \
  $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp'

##################################################
# ==> Path
##################################################
