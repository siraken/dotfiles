{ config, dotfilesPath }:
let
  # Use string concatenation (+) instead of interpolation to avoid Nix store copy
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink (dotfilesPath + path);
in
{
  # bash (TODO: to be removed later)
  ".bashrc".source = "${dotfilesPath}/.config/bash/.bashrc";
  ".bash_profile".source = "${dotfilesPath}/.config/bash/.bash_profile";
  ".config/bash".source = "${dotfilesPath}/.config/bash";

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

  # Mutable symlinks (using mkOutOfStoreSymlink for direct file access)
  # AI Agents
  ".claude/settings.json".source = mkSymlink "/.agents/claude/settings.json";
  ".claude/CLAUDE.md".source = mkSymlink "/.agents/claude/CLAUDE.md";
  ".gemini/settings.json".source = mkSymlink "/.agents/gemini/settings.json";

  # Neovim
  ".config/nvim".source = mkSymlink "/.config/nvim";
}
