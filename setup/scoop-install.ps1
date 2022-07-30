$packages = @(
    "neofetch",
    "neovim"
)

foreach ($package in $packages) {
    scoop install $package
}
