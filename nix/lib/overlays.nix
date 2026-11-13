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

  # rustaceanvim 9.2.2's integration specs (spec/integration/lsp_spec.lua) fail
  # on macOS ("E95: Buffer with this name already exists"), so the Darwin build
  # never reaches the binary cache and nixvim cannot be built. The plugin itself
  # is fine and the same tests pass on Linux, so skip them on Darwin only. Drop
  # this once nixpkgs has a cached aarch64-darwin build again.
  (final: prev: {
    luajit =
      if final.stdenv.hostPlatform.isDarwin then
        prev.luajit.override {
          packageOverrides = _luaFinal: luaPrev: {
            rustaceanvim = luaPrev.rustaceanvim.overrideAttrs { doCheck = false; };
          };
        }
      else
        prev.luajit;
  })
]
