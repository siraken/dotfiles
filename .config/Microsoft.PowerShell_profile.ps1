#
# PowerShell Configuration
#

# Variables
$env:POSH_MY_THEME = "powerline"

# Initialize with Starship or Oh My Posh
# Invoke-Expression (&starship init powershell)

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$env:POSH_MY_THEME.omp.json" | Invoke-Expression

# Set Oh My Posh theme


# --- Functions
function Get-GitStatus {
    & git status $args
}

# --- Aliases
Set-Alias wget Invoke-WebRequest
Set-Alias which Get-Command

Set-Alias Chrome "C:\Program Files\Google\Chrome\Application\chrome.exe"
Set-Alias Brave "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

Set-Alias g git
Set-Alias gs Get-GitStatus
