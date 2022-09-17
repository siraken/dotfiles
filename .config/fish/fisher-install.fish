info_message "Checking if fisher and its plugins are installed..."\n

# fisher
if not type -q fisher
  error_message "NOT FOUND: fisher"
  echo "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
end

# tide
if not type -q tide
  error_message "NOT FOUND: tide"
  echo "fisher install IlanCosman/tide@v5"
end

# z
if not type -q z
  error_message "NOT FOUND: z"
  echo "fisher install jethrokuan/z"
end
