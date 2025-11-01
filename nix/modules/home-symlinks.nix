{ config, dotfilesPath }:
{
  # Simple bar
  ".simplebarrc".source = "${dotfilesPath}/.config/simple-bar/.simplebarrc";

  # Vim
  ".ideavimrc".source = "${dotfilesPath}/.config/idea/.ideavimrc";

  # Hyper
  ".hyper.js".source = "${dotfilesPath}/.config/hyper/.hyper.js";

  # XDG config directories
  ".config/husky".source = "${dotfilesPath}/.config/husky";
  ".config/git/hooks".source = "${dotfilesPath}/.config/git/hooks";
  # ".config/emacs".source = "${dotfilesPath}/.config/emacs"; # Contains unsupported file types (sockets)
  ".config/nano".source = "${dotfilesPath}/.config/nano";
  ".config/wezterm".source = "${dotfilesPath}/.config/wezterm";
  ".config/sketchybar".source = "${dotfilesPath}/.config/sketchybar";
}
