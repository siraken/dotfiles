$packages = @(
    "bottom",
    "neofetch",
    "neovim"
)

foreach ($package in $packages) {
    scoop install $package
}
