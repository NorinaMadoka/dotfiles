{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;

    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    # I use coc only for coc-discord-rpc
    coc = {
      enable = true;
      settings = {
        # Disable coc suggestion
        definitions.languageserver.enable = false;
        suggest.autoTrigger = "none";

        # :CocInstall coc-discord-rpc
        # coc-discord-rpc
        rpc = {
          checkIdle = false;
          detailsViewing = "In {workspace_folder}";
          detailsEditing = "{workspace_folder}";
          lowerDetailsEditing = "Working on {file_name}";
        };
      };
    };

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      vim-nix
      vim-tmux-navigator
      plenary-nvim
      dashboard-nvim
      lualine-nvim
      nvim-tree-lua
      bufferline-nvim
      nvim-colorizer-lua
      impatient-nvim
      telescope-nvim
      indent-blankline-nvim
      nvim-treesitter.withAllGrammars
      comment-nvim
      vim-fugitive
      nvim-web-devicons
      lsp-format-nvim
      which-key-nvim
      hop-nvim

      gitsigns-nvim
      # neogit

      # Cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      nvim-lspconfig
      luasnip
      lspkind-nvim
      cmp_luasnip
    ];

    extraPackages = with pkgs; [
      # Nix
      nil
      alejandra

      # Lua
      lua-language-server
      stylua

      # C/C++
      gcc
      clang
      clang-tools # for headers stuff

      # Etc
      rust-analyzer
      ripgrep
      fd
    ];
    # https://github.com/fufexan/dotfiles/blob/main/home/editors/neovim/default.nix#L41
    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
          ./lua
          + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "cmp"
        "colorizer"
        "keybind"
        "settings"
        "theme"
        "ui"
        "which-key"
      ]);
    in ''
      set guicursor=n-v-c-i:block
      lua << EOF
      ${luaConfig}
      EOF
    '';
  };
}
