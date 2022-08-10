#
# PowerShell Configuration
#

# Initialize with Starship or Oh My Posh
# Invoke-Expression (&starship init powershell)
oh-my-posh init pwsh | Invoke-Expression

# --- Functions
function Get-GitStatus {
  & git status $args
}

# --- Aliases
Set-Alias wget Invoke-WebRequest
Set-Alias which Get-Command

Set-Alias Chrome "C:\Program Files\Google\Chrome\Application\chrome.exe"
Set-Alias Brave "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias g git
Set-Alias gs Get-GitStatus

