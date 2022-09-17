# echo "Checking if fisher and its plugins are installed..."

# fisher
if not type -q fisher
  echo "To install fisher, run:"
  echo "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
end

# tide
if not type -q tide
  echo "To install tide, run:"
  echo "fisher install IlanCosman/tide@v5"
end

# z
if not type -q z
  echo "To install z, run:"
  echo "fisher install jethrokuan/z"
end
