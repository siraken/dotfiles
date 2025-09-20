{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      mgr = {
        ratio = [2 3 3];
        sort_by = "none";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        show_symlink = true;
        mouse_events = ["click" "scroll" "touch" "move" "drag"];
      };
    };
  };
}
