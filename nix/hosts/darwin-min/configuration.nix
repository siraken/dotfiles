{
  ...
}:
{
  imports = [
    ../../modules/darwin/common.nix
  ];

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
    masApps = { };
  };
}
