$global:INSTALLING_FILE = ""
$global:ERROR_COUNT = 0

function _INSTALL($name) {
  Write-Host "Installing: " -ForegroundColor Green -NoNewline
  Write-Host $name
  $global:INSTALLING_FILE = $name
}

function _ERROR {
  Write-Host " Error " -BackgroundColor Red -ForegroundColor White -NoNewline
  Write-Host " $global:INSTALLING_FILE "
  $global:ERROR_COUNT += 1
}

function _FINISH {
  Write-Host " Done " -ForegroundColor White -BackgroundColor Green
  if ($global:ERROR_COUNT -gt 0) {
    Write-Host " $($global:ERROR_COUNT) errors " -ForegroundColor White -BackgroundColor Red
  }
}

_INSTALL PowerShell
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\powershell\windows.ps1 -Path $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

_INSTALL Starship
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\starship.toml -Path $env:USERPROFILE\.config\starship.toml

_INSTALL NeoVim
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\nvim\ -Path $env:USERPROFILE\AppData\Local\nvim

_INSTALL Hyper
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.hyper.js -Path $env:USERPROFILE\AppData\Roaming\Hyper\.hyper.js

_INSTALL Nushell
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\nushell\ -Path $env:USERPROFILE\AppData\Roaming\nushell

_INSTALL Git
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\git\ -Path $env:USERPROFILE\.config\git
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\git\conf.d\os\windows.conf -Path $env:USERPROFILE\.config\git\conf.d\credential.conf

_INSTALL Alacritty
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\alacritty\ -Path $env:APPDATA\alacritty

_INSTALL WezTerm
New-Item -Force -ItemType SymbolicLink -Value $env:USERPROFILE\dotfiles\.config\wezterm\ -Path $env:USERPROFILE\.config\wezterm

trap {
  _ERROR
}

_FINISH


