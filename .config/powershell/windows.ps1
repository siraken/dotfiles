#
# PowerShell Configuration
# for Windows
#

Invoke-Expression (&starship init powershell)

Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

# .".\variable"
# .".\function"
# .".\alias"
