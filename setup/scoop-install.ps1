$packages = @(
    "bottom",
    "neofetch",
    "neovim",
    "spotify-tui"
)

foreach ($package in $packages) {
    scoop install $package
}
