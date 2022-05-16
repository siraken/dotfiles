# Can I Use Search from Fish

function cani
  set query (string join "+" $argv)
  open "https://caniuse.com/?search="$query
end
