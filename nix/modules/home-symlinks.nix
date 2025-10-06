{ config, dotfilesPath }:
{
  # Shell configurations
  ".bashrc".source = "${dotfilesPath}/.config/bash/.bashrc";
  ".bash_profile".source = "${dotfilesPath}/.config/bash/.bash_profile";
  ".zprofile".source = "${dotfilesPath}/.config/zsh/.zprofile";
  ".zshrc".source = "${dotfilesPath}/.config/zsh/.zshrc";

  # Simple bar
  ".simplebarrc".source = "${dotfilesPath}/.config/simple-bar/.simplebarrc";

  # Vim
  ".vimrc".source = "${dotfilesPath}/.config/vim/.vimrc";
  ".ideavimrc".source = "${dotfilesPath}/.config/idea/.ideavimrc";

  # Hyper
  ".hyper.js".source = "${dotfilesPath}/.config/hyper/.hyper.js";

  # VSCode snippets
  ".vsnip".source = "${dotfilesPath}/.vsnip";

  # XDG config directories
  ".config/bash".source = "${dotfilesPath}/.config/bash";
  ".config/zsh".source = "${dotfilesPath}/.config/zsh";
  ".config/fish".source = "${dotfilesPath}/.config/fish";
  ".config/husky".source = "${dotfilesPath}/.config/husky";
  ".config/mise".source = "${dotfilesPath}/.config/mise";
  ".config/git/hooks".source = "${dotfilesPath}/.config/git/hooks";
  # ".config/emacs".source = "${dotfilesPath}/.config/emacs"; # Contains unsupported file types (sockets)
  ".config/nano".source = "${dotfilesPath}/.config/nano";
  ".config/neovide".source = "${dotfilesPath}/.config/neovide";
  ".config/wezterm".source = "${dotfilesPath}/.config/wezterm";
  ".config/ghostty".source = "${dotfilesPath}/.config/ghostty";
  ".config/sketchybar".source = "${dotfilesPath}/.config/sketchybar";
  ".config/borders".source = "${dotfilesPath}/.config/borders";

  # Zed settings (specific file)
  ".config/zed/settings.json".source = "${dotfilesPath}/.config/zed/settings.json";

  # Claude configuration
  ".claude/commands".source = "${dotfilesPath}/.config/claude/commands";
}
