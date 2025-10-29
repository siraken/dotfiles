{ config, dotfilesPath }:
{
  # Shell configurations
  ".bashrc".source = "${dotfilesPath}/.config/bash/.bashrc";
  ".bash_profile".source = "${dotfilesPath}/.config/bash/.bash_profile";

  # Simple bar
  ".simplebarrc".source = "${dotfilesPath}/.config/simple-bar/.simplebarrc";

  # Vim
  ".ideavimrc".source = "${dotfilesPath}/.config/idea/.ideavimrc";

  # Hyper
  ".hyper.js".source = "${dotfilesPath}/.config/hyper/.hyper.js";

  # VSCode snippets
  ".vsnip".source = "${dotfilesPath}/.vsnip";

  # XDG config directories
  ".config/bash".source = "${dotfilesPath}/.config/bash";
  ".config/husky".source = "${dotfilesPath}/.config/husky";
  ".config/mise".source = "${dotfilesPath}/.config/mise";
  ".config/git/hooks".source = "${dotfilesPath}/.config/git/hooks";
  # ".config/emacs".source = "${dotfilesPath}/.config/emacs"; # Contains unsupported file types (sockets)
  ".config/nano".source = "${dotfilesPath}/.config/nano";
  ".config/wezterm".source = "${dotfilesPath}/.config/wezterm";
  ".config/ghostty".source = "${dotfilesPath}/.config/ghostty";
  ".config/sketchybar".source = "${dotfilesPath}/.config/sketchybar";
}
