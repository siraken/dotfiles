# Provides the `mkRepoLink` and `repoPath` helpers to all home-manager program
# modules via `_module.args`, and the `dotfiles.linkMode` option that decides
# where they point.
#
# - `mkRepoLink rel` is a `home.file.<name>.source` for a repo file.
# - `repoPath rel` is the path string to embed in a generated config that pulls
#   a repo file in (tmux `source-file`, git `includes`, kitty `include`, …).
#
# `rel` is a path string relative to the repo root, e.g.
# `mkRepoLink "config/nano/nanorc"`. It must be a string (a path literal would
# be copied into the Nix store and defeat the out-of-store mode).
#
# linkMode:
# - "outOfStore": point into the checkout at `dotfiles.path` (`~/dotfiles`), so
#   the file is editable in place without a rebuild. Requires the clone. See #70.
# - "store": point at the copy of the flake source in the Nix store. Works on a
#   host that applied the flake straight from GitHub without cloning it; an
#   edit takes effect on the next switch.
{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.dotfiles;
  root = if cfg.linkMode == "outOfStore" then cfg.path else "${inputs.self}";
in
{
  options.dotfiles = {
    linkMode = lib.mkOption {
      type = lib.types.enum [
        "outOfStore"
        "store"
      ];
      default = "store";
      description = ''
        Where repo-managed config files are linked from. "outOfStore" needs the
        repo checked out at `dotfiles.path`; "store" does not.
      '';
    };

    path = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/dotfiles";
      description = "Location of the dotfiles checkout, for files that live outside the repo's tracked tree.";
    };
  };

  config._module.args = {
    repoPath = rel: "${root}/${rel}";
    mkRepoLink =
      rel:
      if cfg.linkMode == "outOfStore" then
        config.lib.file.mkOutOfStoreSymlink "${cfg.path}/${rel}"
      else
        "${inputs.self}/${rel}";
  };
}
