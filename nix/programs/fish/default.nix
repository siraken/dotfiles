{ pkgs, ... }:
let
  functionsScript = builtins.readFile ./function.fish;
  completionScript = builtins.readFile ./completion.fish;
in
{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "main";
          sha256 = "0mcpn4iqq7f005gk98ppxwi7r1j0fqybwfj69g1bw8dk9wlm27m5";
        };
      }
      {
        name = "fish-plugin-template";
        src = pkgs.fetchFromGitHub {
          owner = "yo-goto";
          repo = "fish-plugin-template";
          rev = "master";
          sha256 = "1w2wpmxxmh5y187dkxpswnr3gcmri6slk80s8cb4kkzm7hn4pq8j";
        };
      }
    ];

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Custom functions
      ${functionsScript}

      # Completions
      ${completionScript}

      # Conditional aliases
      if type -q bat
        alias cat="bat"
      end

      if type -q eza
        alias ll="eza -l -g --icons"
        alias lla="ll -a"
      end
    '';
  };
}
