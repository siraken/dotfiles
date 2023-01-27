# PowerShell
Write-Host "Installing PowerShell"
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\powershell\windows.ps1 -Path $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# Starship
Write-Host "Installing Starship"
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\starship.toml -Path $env:USERPROFILE\.config\starship.toml

# NeoVim
Write-Host "Installing NeoVim"
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\nvim\ -Path $env:USERPROFILE\AppData\Local\nvim

# Hyper
Write-Host "Installing Hyper"
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.hyper.js -Path $env:USERPROFILE\AppData\Roaming\Hyper\.hyper.js
