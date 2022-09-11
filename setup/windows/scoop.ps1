# Packages: https://scoop.sh/#/apps
$packages = @(
    "googlechrome"
    "firefox"
    "thunderbird"
    "winscp"
    "7zip"
    "git"
    "gcc"
    "cmake"
    "maven"
    "python"
    "steam"
    "ffmpeg"
    "sourcetree"
    "winmerge"
    "wireshark"
    "bottom"
    "neofetch"
    "vscode"
    "vscode-insiders"
    "vagrant"
    "volta"
    # "virtualbox-np"
    "neovim"
    "tree-sitter"
    "ruby"
    "msys2"
    "jetbrains-toolbox"
    "spotify-tui"
    "zig"
    "jmeter"
    "Hack-NF"
    "Hack-NF-Mono"
)

# Buckets: https://scoop.sh/#/buckets
$buckets = @(
    "extras"
    "versions"
    "php"
    "nerd-fonts"
)

# Disable error
$ErrorActionPreference = "silentlycontinue"

if (Get-Command scoop) {
    Write-Host "Scoop is already installed. `r`n" -ForegroundColor Green

    # Enable error
    $ErrorActionPreference = "continue"
}
else {
    Write-Host "Scoop is not installed." -ForegroundColor Red
    Write-Host "Installing Scoop... `r`n"

    # Enable error
    $ErrorActionPreference = "continue"

    # Install Scoop
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
    Write-Host "Scoop is successfully installed! `r`n" -ForegroundColor Green
}

# Add buckets
Write-Host ("Adding " + $buckets.count + " buckets...`r`n")
foreach ($bucket in $buckets) {
    scoop bucket add $bucket
}

# Install packages
Write-Host ("Installing " + $packages.count + " packages...`r`n")
foreach ($package in $packages) {
    scoop install $package
}

Write-Host "`r`nInstallation is successfully completed." -ForegroundColor Green
