{ config, dotfilesPath }:
let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
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

  # Mutable symlinks (previously managed by ./symlink script)
  # AI Agents
  ".claude/settings.json".source = mkSymlink "${dotfilesPath}/.agents/claude/settings.json";
  ".claude/CLAUDE.md".source = mkSymlink "${dotfilesPath}/.agents/claude/CLAUDE.md";
  ".gemini/settings.json".source = mkSymlink "${dotfilesPath}/.agents/gemini/settings.json";

  # Neovim
  ".config/nvim".source = mkSymlink "${dotfilesPath}/.config/nvim";
}
