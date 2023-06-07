{
  config,
  lib,
  pkgs,
  ...
}: rec {
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  gtk = {
    enable = true;
    font = {
      name = "SF Pro Rounded";
      size = 11;
    };

    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
    };

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    cursorTheme = {
      name = "capitaine-cursors-white";
      size = 24;
      package = pkgs.capitaine-cursors;
    };

    gtk2.extraConfig = "gtk-cursor-theme-size=24";
    gtk3.extraConfig."gtk-cursor-theme-size" = 24;
    gtk4.extraConfig."gtk-cursor-theme-size" = 24;
  };

  home.file = {
    ".icons/default/index.theme".text = ''
      [icon theme]
      Name=Default
      Comment=Default Cursor Theme
      Inherits=${gtk.cursorTheme.name}
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "${gtk.theme.name}";
      icon-theme = "${gtk.iconTheme.name}";
      cursor-theme = "${gtk.cursorTheme.name}";
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    exa = {
      enable = true;
      enableAliases = false;
    };

    git = {
      enable = true;

      userEmail = "ludovicopiero@pm.me";
      userName = "Ludovico";

      signing = {
        key = "3911DD276CFE779C";
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };

      aliases = {
        a = "add -p";
        co = "checkout";
        cob = "checkout -b";
        f = "fetch -p";
        c = "commit -s";
        p = "push";
        ba = "branch -a";
        bd = "branch -d";
        bD = "branch -D";
        d = "diff";
        dc = "diff --cached";
        ds = "diff --staged";
        r = "restore";
        rs = "restore --staged";
        st = "status -sb";

        # reset
        soft = "reset --soft";
        hard = "reset --hard";
        s1ft = "soft HEAD~1";
        h1rd = "hard HEAD~1";

        # logging
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        plog = "log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'";
        tlog = "log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative";
        rank = "shortlog -sn --no-merges";

        # delete merged branches
        bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d";
      };
    };

    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };

    home-manager.enable = true;
    nix-index.enable = true;

    starship = {
      enable = true;
      settings = import ./config/starship.nix {inherit lib;};
    };

    zsh = let
      _ = lib.getExe;
    in {
      enable = true;
      defaultKeymap = "emacs";

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        save = 50000;
      };

      initExtra = with pkgs; let
        args = "--hwdec=dxva2 --gpu-context=d3d11 --no-keepaspect-window --keep-open=no --force-window=yes --force-seekable=yes --hr-seek=yes --hr-seek-framedrop=yes";
      in ''
        eval "$(starship init zsh)"
        ${_ any-nix-shell} zsh --info-right | source /dev/stdin
        eval "$(direnv hook zsh)"

        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-colors '\'
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true
        _comp_options+=(globdots)

        gitignore(){
          curl -sL https://www.gitignore.io/api/$@
        }

        run(){
          nix run nixpkgs#$@
        }

        watchLive(){
            ${_ pkgs.streamlink} --player ${_ pkgs.mpv} --twitch-disable-hosting \
            --twitch-low-latency --player-args "${args}" --player-continuous-http \
            --player-no-close --hls-live-edge 2 --stream-segment-threads 2 --retry-open 15 \
            --retry-streams 15 $argv best -a --ontop -a --no-border
        }

      '';
      shellAliases = with pkgs; {
        "bs" = "pushd ~/.config/nixos && doas nixos-rebuild switch --flake .#sforza && popd";
        "bb" = "pushd ~/.config/nixos && doas nixos-rebuild boot --flake .#sforza && popd";
        "hs" = "pushd ~/.config/nixos && home-manager switch --flake .#ludovico && popd";
        "cat" = _ bat;
        "config" = "cd ~/.config/nixos";
        "ls" = "${_ exa} --icons";
        "l" = "${_ exa} -lbF --git --icons";
        "ll" = "${_ exa} -lbGF --git --icons";
        "llm" = "${_ exa} -lbGF --git --sort=modified --icons";
        "la" = "${_ exa} -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
        "lx" = "${_ exa} -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons";
        "tree" = "${_ exa} --tree --icons";
        "nv" = "nvim";
        "mkdir" = "mkdir -p";
        "g" = "git";
        "gcl" = "g clone";
        "gd" = "g diff HEAD";
        "gpl" = "g pull";
        "gpsh" = "g push -u origin";
        "gs" = "g status";
        "sudo" = "doas";
        "..." = "cd ../..";
        ".." = "cd ..";
      };

      plugins = [
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "1386f1213eb0b0589d73cd3cf7c56e6a972a9bfd";
            sha256 = "sha256-iKx7lsQCoSAbpANYFkNVCZlTFdwOEI34rx/h1rnraSg=";
          };
        }
        {
          name = "zsh-autosuggestions";
          file = "zsh-autosuggestions.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-completions";
          file = "zsh-completions.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/zsh-users/zsh-completions";
            rev = "66c4b6fe720fc34bd18dbb879aa005fc7352c65b";
          };
        }
        {
          name = "enhancd";
          file = "init.sh";
          src = pkgs.fetchFromGitHub {
            owner = "b4b4r07";
            repo = "enhancd";
            rev = "v2.5.1";
            sha256 = "sha256-kaintLXSfLH7zdLtcoZfVNobCJCap0S/Ldq85wd3krI=";
          };
        }
        {
          name = "forgit";
          file = "forgit.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/wfxr/forgit";
            rev = "665e3fd215fe68ad066af1ad732e8618990da5a6";
          };
        }
      ];
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  systemd.user = {
    timers.nix-index-db-update = {
      Timer = {
        OnCalendar = "weekly";
        Persistent = true;
        RandomizedDelaySec = 0;
      };
    };
    services.nix-index-db-update = {
      Unit = {
        Description = "nix-index database update";
        PartOf = ["multi-user.target"];
      };
      Service = let
        script = pkgs.writeShellScript "nix-index-update-db" ''
          export filename="index-x86_64-$(uname | tr A-Z a-z)"
          mkdir -p ~/.cache/nix-index
          cd ~/.cache/nix-index
          # -N will only download a new version if there is an update.
          wget -N https://github.com/Mic92/nix-index-database/releases/latest/download/$filename
          ln -f $filename files
        '';
      in {
        Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath [pkgs.wget pkgs.coreutils]}";
        ExecStart = "${script}";
      };
      Install.WantedBy = ["multi-user.target"];
    };
  };

  xdg = let
    browser = ["firefox.desktop"];
    mailspring = ["Mailspring.desktop"];

    # XDG MIME types
    associations = {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;

      "audio/*" = ["mpv.desktop"];
      "video/*" = ["mpv.dekstop"];
      "image/*" = ["imv.desktop"];
      "application/json" = browser;
      "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
      "x-scheme-handler/discord" = ["discordcanary.desktop"];
      "x-scheme-handler/spotify" = ["spotify.desktop"];
      "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
      "x-scheme-handler/mailto" = mailspring;
      "message/rfc822" = mailspring;
      "x-scheme-handler/mid" = mailspring;
    };
  in {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
        XDG_MISC_DIR = "${config.home.homeDirectory}/Code";
      };
    };
  };
}
