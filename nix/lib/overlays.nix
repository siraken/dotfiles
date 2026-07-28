# Shared nixpkgs overlays.
#
# Applied by every host builder (`mk-darwin-host.nix` / `mk-nixos-host.nix`), so
# a new overlay lands on all profiles at once instead of being copy-pasted per
# host.
{ inputs }:
[
  (final: _prev: {
    llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};
  })
]
