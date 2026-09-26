# Binary caches this repo relies on. Applied by the OS-level module
# (`nix-caches.nix`, nix-darwin / NixOS); on a non-NixOS Linux host, print the
# matching system nix.conf lines with `nix run .#nix-cache-conf`.
{
  substituters = [
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://cache.numtide.com"
    # 上流がビルドしていないもの (mise、unfree な 1password-cli、emacs パッケージ、
    # このリポジトリ由来の派生) を置く自前のキャッシュ。`nix-cache-push` で更新する。
    "https://siraken-dotfiles.cachix.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    "siraken-dotfiles.cachix.org-1:UJ/LRyGgN5R3AagxTnKTFbbprNu2G3Ylg6LYTgPmc/w="
  ];
}
