# Binary caches this repo relies on. Applied by the OS-level module
# (`nix-caches.nix`, nix-darwin / NixOS); on a non-NixOS Linux host, print the
# matching system nix.conf lines with `nix run .#nix-cache-conf`.
#
# cache.nixos.org and its key are left out: nix-darwin and NixOS already add
# them by default, and `nix-cache-conf` prints `extra-*` lines on top of the
# built-in default (#163).
{
  substituters = [
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://cache.numtide.com"
    # 上流がビルドしていないもの (mise、unfree な 1password-cli、emacs パッケージ、
    # このリポジトリ由来の派生) を置く自前のキャッシュ。`nix-cache-push` で更新する。
    "https://siraken-dotfiles.cachix.org"
  ];
  trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    "siraken-dotfiles.cachix.org-1:UJ/LRyGgN5R3AagxTnKTFbbprNu2G3Ylg6LYTgPmc/w="
  ];
}
