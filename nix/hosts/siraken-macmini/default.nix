{
  inputs,
  userProfile,
  backupFileExtension,
}:
(import ../../lib/mk-darwin-host.nix { inherit inputs userProfile backupFileExtension; }) {
  hostName = "siraken-macmini";
  homeModule = ./home.nix;
  modules = [
    {
      homebrew = {
        brews = [
          "ansible"
          "cloudflared"
        ];
        casks = [
          "alt-tab"
          "appcleaner"
          "drivedx"
          "ghostty"
          "github"
          "google-chrome"
          "thebrowsercompany-dia"
          "visual-studio-code"
          "vivaldi"
          "raycast"
        ];
      };
    }
  ];
}
