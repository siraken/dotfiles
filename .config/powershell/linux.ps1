#
# PowerShell Configuration
# for Linux / macOS
#

# --- Functions
function Get-GitStatus {
    & git status $args
}

# --- Aliases
Set-Alias g git
Set-Alias gs Get-GitStatus
