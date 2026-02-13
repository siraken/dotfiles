{ ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # Disabled in original config - uncomment to enable
    # treesitter-textobjects.enable = true;
    # treesitter-context = {
    #   enable = true;
    #   settings = {
    #     mode = "cursor";
    #     max_lines = 3;
    #   };
    # };

    ts-autotag.enable = true;

    ts-comments.enable = true;
  };
}
