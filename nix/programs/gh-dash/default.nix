{ pkgs, ... }:
{
  programs.gh-dash = {
    enable = true;
    settings = {
      prSections = [
        { filters = "is:open author:@me"; }
      ];
    };
  };
}
