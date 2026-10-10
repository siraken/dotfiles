# gau - Git Add URL
# Add a GitHub remote named after the current directory as origin
read -rp "Enter the username: " username
if [ -z "$username" ]; then
  echo "Please provide the username you want to use." >&2
  exit 1
fi

git remote add origin "https://github.com/$username/$(basename "$PWD").git"
git remote -v
