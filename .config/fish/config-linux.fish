##################################################
# > Linux Config
##################################################

# Aliases
alias ii="open"
alias mamp-htdocs="cd /Applications/MAMP/htdocs"
alias lisp-server='sbcl --load \
  $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp'

if type -q bat
  alias cat="bat"
end

if type -q exa
  alias ll="exa -l -g --icons"
  alias lla="ll -a"
end
