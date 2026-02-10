{
  inputs,
  user,
  backupFileExtension,
}:
inputs.nix-on-droid.lib.nixOnDroidConfiguration {
  system = "aarch64-linux";
  modules = [
    ./configuration.nix
  ];
}
