# Common Lisp development
{ pkgs, ... }:
let
  vlime = pkgs.vimUtils.buildVimPlugin {
    pname = "vlime";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "vlime";
      repo = "vlime";
      rev = "d3e2c1e65e32e30c05bdc54c05728a4ecfef6ed0";
      hash = "sha256-PBOD6AaRMXu8bw9cxPU/fZtNmZbEQm3q30OPE6NWwko=";
    };
  };
in
{
  programs.nixvim = {
    globals.vlime_cl_impl = "sbcl";

    extraPlugins = [ vlime ];
  };
}
