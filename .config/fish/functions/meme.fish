# Know Your Meme Search from Fish

function meme
  set query (string join "+" $argv)
  open "https://knowyourmeme.com/search?q="$query
end
