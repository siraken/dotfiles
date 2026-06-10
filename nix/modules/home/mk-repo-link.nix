# Provides the `mkRepoLink` helper to all home-manager program modules via
# `_module.args`. It returns an out-of-store symlink into the ~/dotfiles
# checkout, so the linked file is editable in place without a rebuild.
#
# The argument is a path string relative to the repo root, e.g.
# `mkRepoLink "nix/programs/nano/nanorc"`. It must be a string (a path literal
# would be copied into the Nix store and defeat the out-of-store intent).
#
# Assumes the repo is checked out at `~/dotfiles`. See #70.
{ config, ... }:
{
  _module.args.mkRepoLink =
    rel: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${rel}";
}
