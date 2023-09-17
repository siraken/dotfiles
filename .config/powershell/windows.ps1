#
# PowerShell Configuration
# for Windows
#

. $env:USERPROFILE\dotfiles\.config\powershell\includes\variable.ps1
. $env:USERPROFILE\dotfiles\.config\powershell\includes\function.ps1
. $env:USERPROFILE\dotfiles\.config\powershell\includes\alias.ps1

Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

Invoke-Expression (&starship init powershell)
