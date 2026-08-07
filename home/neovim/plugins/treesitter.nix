{ config, ... }:
{
  programs.nixvim = {
    dependencies = {
      tree-sitter.enable = true;
    };

    # see https://github.com/nvim-treesitter/nvim-treesitter/
    plugins = {
      treesitter =
        let
          grammarBuilder = config.programs.nixvim.plugins.treesitter.package.builtGrammars;
        in
        {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
          grammarPackages = with grammarBuilder; [
            awk
            bash
            blade
            c
            cmake
            comment
            cpp
            css
            csv
            desktop
            diff
            dockerfile
            ebnf
            editorconfig
            fish
            gitattributes
            gitcommit
            git_config
            gitignore
            git_rebase
            go
            gomod
            gosum
            gotmpl
            gpg
            graphql
            hlsplaylist
            html
            http
            hyprlang
            ini
            java
            javadoc
            javascript
            jq
            jsdoc
            json
            just
            kconfig
            latex
            llvm
            lua
            luadoc
            make
            markdown
            meson
            nginx
            nix
            objdump
            passwd
            pem
            php
            phpdoc
            printf
            properties
            puppet
            python
            rasi
            regex
            requirements
            robots_txt
            rust
            scss
            sql
            ssh_config
            strace
            svelte
            sway
            textproto
            tmux
            toml
            twig
            typescript
            udev
            vim
            vimdoc
            vue
            xml
            yaml
          ];
        };
    };
  };
}
