{ config, ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      # nixvim defaults `grammarPackages` to all 320 grammars, and nvim-treesitter
      # emits one uncacheable `nvim-treesitter-queries-*` derivation per grammar —
      # 323 local builds on every nixpkgs/nixvim bump, the single largest source of
      # local rebuilds in this flake. Narrow it to the languages this config
      # actually targets: the LSP servers in ../lsp, the language plugins in
      # ../lang, and the file types living in this repo.
      #
      # Adding a language back is a one-line change here.
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        # this repo / shells
        bash
        fish
        make
        nix
        # web
        css
        graphql
        html
        javascript
        jsdoc
        scss
        tsx
        typescript
        # data / config
        ini
        json
        json5
        sql
        toml
        xml
        yaml
        # docs
        markdown
        markdown_inline
        # languages
        c
        dart
        go
        gomod
        gosum
        gowork
        java
        lua
        luadoc
        luap
        php
        php_only
        phpdoc
        python
        ruby
        rust
        scala
        # infra
        dockerfile
        hcl
        terraform
        ssh_config
        # git
        git_config
        git_rebase
        gitcommit
        gitignore
        # editor internals (injections used by other grammars)
        comment
        diff
        query
        regex
        vim
        vimdoc
      ];

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
