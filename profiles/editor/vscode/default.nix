{
  config,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.${config.vars.username} = {
    home.packages = [
      inputs.nil.packages.${pkgs.system}.default
    ];
    programs.vscode = {
      enable = true;
      # package = pkgs.vscodium; # use vscode because copilot no worky :(
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "editor.cursorBlinking" = "phase";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.fontFamily" = "'Iosevka Nerd Font', 'monospace', monospace";
        "editor.fontSize" = 18;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "none";
        "editor.scrollbar.vertical" = "hidden";
        "editor.smoothScrolling" = true;
        "extensions.autoCheckUpdates" = false;
        "files.autoSave" = "onWindowChange";
        "gitlens.currentLine.enabled" = false;
        "gitlens.hovers.currentLine.over" = "line";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "formatting" = {
            "command" = "alejandra";
          };
        };
        "update.mode" = "none";
        "vscord.status.details.text.editing" = "In {full_directory_name}";
        "vscord.status.idle.check" = false;
        "vscord.status.problems.enabled" = false;
        "vscord.status.state.text.editing" = "Working on {file_name}{file_extension}";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.editor.limit.enabled" = true;
        "workbench.editor.limit.perEditorGroup" = true;
        "workbench.editor.limit.value" = 5;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
      };
      extensions = with pkgs.vscode-extensions;
        [
          # Theme & flair
          catppuccin.catppuccin-vsc
          pkief.material-icon-theme

          # Nix
          # bbenoist.nix
          jnoortheen.nix-ide
          kamadorueda.alejandra

          # Python
          ms-python.python

          # Go
          golang.go

          # Lua
          sumneko.lua

          # Rust
          rust-lang.rust-analyzer
          serayuzgur.crates

          # Misc
          usernamehw.errorlens
          eamodio.gitlens
          esbenp.prettier-vscode
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            publisher = "leonardssh";
            name = "vscord";
            version = "5.1.10";
            sha256 = "1nw3zvlw0bx9yih4z3i20irdw02zz444ncf84xjvjn6h5hw47i3x";
          }
        ];
    };
  };
}
