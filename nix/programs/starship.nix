{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 500;
      scan_timeout = 30;
      aws = { disabled = true; };
      docker_context = { disabled = true; };
      gcloud = { disabled = true; };
      memory_usage = {
        disabled = true;
        threshold = -1;
        style = "bold dimmed green";
      };
      sudo = { disabled = false; };
      vagrant = { disabled = true; };
    };
  };
}
