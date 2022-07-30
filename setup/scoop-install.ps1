$packages = @(
    "bottom",
    "neofetch",
    "neovim",
    "spotify-tui",
    "zig",
)

foreach ($package in $packages) {
    scoop install $package
}
