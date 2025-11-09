$DOTFILES_DIR = "$Env:USERPROFILE\dotfiles"

Function New-Symlink {
  param (
    [string]$LinkPath,
    [string]$TargetPath
  )

  if (Test-Path $LinkPath) {
    Remove-Item $LinkPath -Force
  }

  New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath
}

# Komorebi
New-Symlink "$Env:USERPROFILE\komorebi.json" "$DOTFILES_DIR\windows\.config\komorebi.json"
New-Symlink "$Env:USERPROFILE\komorebi.bar.json" "$DOTFILES_DIR\windows\.config\komorebi.bar.json"

# whkd
New-Symlink "$Env:USERPROFILE\whkdrc" "$DOTFILES_DIR\windows\.config\whkdrc"
