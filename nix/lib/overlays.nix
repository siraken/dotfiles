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

  # The prebuilt `purs` segfaults inside ld.so (glibc 2.44) once patchelf
  # rewrites both its interpreter and its rpath in a single call, which breaks
  # the bash-completion step of the build. Running the two edits separately,
  # rpath first, yields a working binary. Drop this once nixpkgs fixes it.
  (final: prev: {
    purescript =
      if final.stdenv.hostPlatform.isLinux then
        prev.purescript.overrideAttrs (old: {
          installPhase = ''
            mkdir -p $out/bin
            PURS="$out/bin/purs"

            install -D -m555 -T purs $PURS
            chmod u+w $PURS
            patchelf --set-rpath ${old.libPath} $PURS
            patchelf --interpreter ${final.stdenv.cc.bintools.dynamicLinker} $PURS
            chmod u-w $PURS

            mkdir -p $out/share/bash-completion/completions
            $PURS --bash-completion-script $PURS > $out/share/bash-completion/completions/purs-completion.bash
          '';
        })
      else
        prev.purescript;
  })
]
