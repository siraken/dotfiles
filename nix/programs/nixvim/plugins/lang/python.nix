# Python development
{ pkgs, ... }:
# TODO: Re-enable when hash is updated
# let
#   venv-selector-nvim = pkgs.vimUtils.buildVimPlugin {
#     pname = "venv-selector-nvim";
#     version = "2024-12-26";
#     src = pkgs.fetchFromGitHub {
#       owner = "linux-cultist";
#       repo = "venv-selector.nvim";
#       rev = "f16c804fbb375d14b69063053f4b2ba66398b4bd";
#       hash = "sha256-5xmKjaN6CMvSwbQ+PpxqsQ1Ps+6IJoDuemXs78J25SY=";
#     };
#   };
# in
{
  programs.nixvim = {
    # TODO: Re-enable venv-selector when hash is updated
    # extraPlugins = [ venv-selector-nvim ];
    #
    # extraConfigLua = ''
    #   require("venv-selector").setup({})
    # '';
    #
    # keymaps = [
    #   { mode = "n"; key = "<leader>cv"; action = "<cmd>VenvSelect<cr>"; options.desc = "Select VirtualEnv"; }
    # ];
  };
}
