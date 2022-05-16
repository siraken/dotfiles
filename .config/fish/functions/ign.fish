# ign - Download .gitignore file

function ign
  curl -fOL https://raw.githubusercontent.com/github/gitignore/main/$argv[1].gitignore
end
