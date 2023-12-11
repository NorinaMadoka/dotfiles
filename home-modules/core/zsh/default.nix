{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.mine.zsh;
  inherit (lib) mkIf mkOption types;
in {
  imports = [inputs.nix-index-database.hmModules.nix-index];

  options.mine.zsh = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable ZSH Shell and Set configuration.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.nix-index-database.comma.enable = true;
    programs.nix-index.enable = true;

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      autocd = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";

      history = {
        expireDuplicatesFirst = true;
        path = "$ZDOTDIR/.zsh_history";
        ignorePatterns = ["rm *" "pkill *"];
      };

      completionInit = "";

      initExtra = let
        _ = lib.getExe;
      in ''
        ${_ pkgs.any-nix-shell} zsh --info-right | source /dev/stdin
        eval "$(${_ pkgs.direnv} hook zsh)"
        zstyle :prompt:pure:environment:nix-shell show no

        # Search history based on what's typed in the prompt
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey "^[OA" history-beginning-search-backward-end
        bindkey "^[OB" history-beginning-search-forward-end
        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-colors '\'
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true
        _comp_options+=(globdots)

        function bs() {
          pushd ~/.config/nixos
          nh os switch .
            if [[ $? -eq 0 ]]; then
              notify-send "Rebuild Switch" "Build successful!"
            else
              notify-send "Rebuild Switch" "Build failed!"
            fi
          popd
        }

        function bb() {
          pushd ~/.config/nixos
          nh os boot .
            if [[ $? -eq 0 ]]; then
              notify-send "Rebuild Boot" "Build successful!"
            else
              notify-send "Rebuild Boot" "Build failed!"
            fi
          popd
        }

        function hs() {
          pushd ~/.config/nixos
          nh home switch .
            if [[ $? -eq 0 ]]; then
              notify-send "Home-Manager Switch" "Build successful!"
            else
              notify-send "Home-Manager Switch" "Build failed!"
            fi
          popd
        }

        function fe() {
          selected_file=$(rg --files ''$argv[1] | ${_ pkgs.fzf} --preview "${_ pkgs.bat} -f {}")
          if [ -n "$selected_file" ]; then
            echo "$selected_file" | xargs $EDITOR
          fi
        }

        function run() { nix run nixpkgs#$@[1] -- $@[2,-1] }
      '';

      dirHashes = {
        c = "$HOME/.config/nixos";
        docs = "$HOME/Documents";
        vids = "$HOME/Videos";
        dl = "$HOME/Downloads";
      };

      shellAliases = let
        _ = lib.getExe;
      in
        with pkgs; {
          "..." = "cd ../..";
          ".." = "cd ..";
          "cat" = "${_ bat}";
          "c" = "${_ commitizen} commit -- -s"; # Commit with Signed-off
          "cp" = "cp -v";
          "dla" = "${_ yt-dlp} --extract-audio --audio-format mp3 --audio-quality 0 -P '${config.home.homeDirectory}/Media/Audios'"; # Download Audio
          "dlv" = "${_ yt-dlp} --format 'best[ext=mp4]' -P '${config.home.homeDirectory}/Media/Videos'"; # Download Video
          "g" = "git";
          "l" = "${_ eza} -lbF --git --icons";
          "la" = "${_ eza} -lbhHigUmuSa --time-style=long-iso --git --icons";
          "lg" = "lazygit";
          "ll" = "${_ eza} -lbGF --git --icons";
          "llm" = "${_ eza} -lbGF --git --sort=modified --icons";
          "ls" = "${_ eza} --icons";
          "lx" = "${_ eza} -lbhHigUmuSa@ --time-style=long-iso --git --icons";
          "mkdir" = "mkdir -p";
          "mv" = "mv -v";
          "nb" = "nix-build -E \'with import <nixpkgs> { }; callPackage ./default.nix { }\'";
          "nv" = "nvim";
          "nr" = "${_ nixpkgs-review}";
          "record" = "${_ wl-screenrec} -f ${config.xdg.userDirs.extraConfig.XDG_RECORD_DIR}/$(date '+%s').mp4";
          "record-region" = "${_ wl-screenrec} -g \"$(${_ slurp})\" -f ${config.xdg.userDirs.extraConfig.XDG_RECORD_DIR}/$(date '+%s').mp4";
          "rm" = "rm -i";
          "t" = "${_ eza} --tree --icons";
          "tree" = "${_ eza} --tree --icons";
          "v" = "nvim";
        };

      plugins = [
        {
          name = "enhancd";
          file = "init.sh";
          src = pkgs.fetchFromGitHub {
            owner = "b4b4r07";
            repo = "enhancd";
            rev = "230695f8da8463b18121f58d748851a67be19a00";
            hash = "sha256-XJl0XVtfi/NTysRMWant84uh8+zShTRwd7t2cxUk+qU=";
          };
        }
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "87e6f5dd4c793f6d980532205aaefe196780606f";
            hash = "sha256-TR4CyBZ+KoZRs9XDmWE5lJuUXXU1J8E2Z63nt+FS+5w=";
          };
        }
      ];
    };
  };
}
