{ pkgs, ... }:
{
  programs.bat = {
    enable = true;

    config = {
      theme = "base16";
      style = "numbers,changes";
    };
  };
}
