{
  inputs,
  userProfile,
}:
(import ../../lib/mk-darwin-host.nix { inherit inputs userProfile; }) {
  hostName = "siraken-macmini";
  # Reached mostly over SSH: base nix-darwin only (no macOS defaults, fonts or
  # window manager). The casks stay for the occasional session at the screen.
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
