# Starship
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\starship.toml -Path $env:USERPROFILE\.config\starship.toml

# NeoVim
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\nvim\ -Path $env:USERPROFILE\AppData\Local\nvim

# Hyper
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.hyper.js -Path $env:USERPROFILE\AppData\Roaming\Hyper\.hyper.js
