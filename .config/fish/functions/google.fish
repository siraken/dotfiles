# Google Search from Fish

function google
  set query (string join "+" $argv)
  open "https://www.google.com/search?q="$query
end
