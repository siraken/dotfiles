#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

$dotfilesDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$dotfilesDir\config\wezterm")) {
    $dotfilesDir = Split-Path -Parent $PSScriptRoot
}

$links = @(
    @{
        Source = "$dotfilesDir\config\wezterm"
        Target = "$env:USERPROFILE\.config\wezterm"
    }
)

foreach ($link in $links) {
    $source = $link.Source
    $target = $link.Target

    if (-not (Test-Path $source)) {
        Write-Warning "Source not found, skipping: $source"
        continue
    }

    $parentDir = Split-Path -Parent $target
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        Write-Host "Created directory: $parentDir"
    }

    if (Test-Path $target) {
        $item = Get-Item $target -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            Write-Host "Symlink already exists: $target -> $(($item).Target)"
            continue
        }
        Write-Warning "Non-symlink already exists at $target. Skipping to avoid data loss."
        Write-Warning "Remove it manually and re-run if you want to replace it."
        continue
    }

    New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
    Write-Host "Created symlink: $target -> $source"
}

Write-Host "`nSetup complete."
