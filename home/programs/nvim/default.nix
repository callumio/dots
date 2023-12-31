{ config, inputs, pkgs, ... }: {
  programs.neovim = let
    leaders = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
    '';
    toLua = str: ''
      lua << EOF
      ${leaders}
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${leaders}
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;

    package = pkgs.neovim-nightly;

    extraPackages = with pkgs; [
      rnix-lsp
      lua-language-server
      rust-analyzer
      gopls
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.pyright
      clang-tools
      ripgrep
      fzf
      statix
      shellcheck
      shfmt
      selene
      stylua
      nixfmt
    ];

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require('Comment').setup()";
      }

      {
        plugin = onedark-nvim;
        config = "colorscheme onedark";
      }

      neodev-nvim

      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      {
        plugin = lualine-nvim;
        config = toLua
          "require('lualine').setup{options = {icons_enabled = true, theme = 'onedark', component_separators = '|', section_separators = ''}, sections = { lualine_a = { { 'buffers', } } }}";
      }

      {
        plugin = nvim-autopairs;
        config = toLua "require('nvim-autopairs').setup {}";
      }

      {
        plugin = leap-nvim;
        config = toLua "require('leap.user').add_default_mappings()";
      }

      {
        plugin = none-ls-nvim;
        config = toLuaFile ./plugin/none-ls.lua;
      }

      {
        plugin = oil-nvim;
        config = toLua "require('oil').setup()";
      }

      {
        plugin = zen-mode-nvim;
        config = toLuaFile ./plugin/zen.lua;
      }
      twilight-nvim

      nvim-web-devicons

      {
        plugin = undotree;
        config =
          toLua "vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)";
      }

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-rust
          p.tree-sitter-json
          p.tree-sitter-c
          p.tree-sitter-comment
          p.tree-sitter-javascript
          p.tree-sitter-fish
          p.tree-sitter-dockerfile
          p.tree-sitter-cpp
          p.tree-sitter-git_config
          p.tree-sitter-git_rebase
          p.tree-sitter-gitattributes
          p.tree-sitter-gitcommit
          p.tree-sitter-gitignore
          p.tree-sitter-markdown
          p.tree-sitter-markdown_inline
          p.tree-sitter-make
          p.tree-sitter-norg
          p.tree-sitter-ssh_config
          p.tree-sitter-typescript
          p.tree-sitter-tsx
          p.tree-sitter-haskell
          p.tree-sitter-yaml
          p.tree-sitter-zig
        ]);
        config = toLuaFile ./plugin/treesitter.lua;
      }

      vim-nix
    ];

  };
}
