# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "4e966509c180f93ba8665cd73cad8456bf44baab";
    src = fetchgit {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme";
      rev = "4e966509c180f93ba8665cd73cad8456bf44baab";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-gIBZCPB0sA8Gagrxd8w4+y9uUkWBnXJBmq9Ur5BYTQU=";
    };
    date = "2024-02-26";
  };
  san-francisco-pro = {
    pname = "san-francisco-pro";
    version = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
    src = fetchgit {
      url = "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts";
      rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-mAXExj8n8gFHq19HfGy4UOJYKVGPYgarGd/04kUIqX4=";
    };
    date = "2021-06-22";
  };
  swayfx = {
    pname = "swayfx";
    version = "2bd366f3372d6f94f6633e62b7f7b06fcf316943";
    src = fetchgit {
      url = "https://github.com/WillPower3309/swayfx";
      rev = "2bd366f3372d6f94f6633e62b7f7b06fcf316943";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-kRWXQnUkMm5HjlDX9rBq8lowygvbK9+ScAOhiySR3KY=";
    };
    date = "2024-02-15";
  };
  waybar = {
    pname = "waybar";
    version = "bdff489850931798814da82e797ff10d71b89670";
    src = fetchgit {
      url = "https://github.com/alexays/waybar";
      rev = "bdff489850931798814da82e797ff10d71b89670";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-BWdD+bfz/J2fyoC/oy+PR6JrRAsCkKori5wrt0yllaQ=";
    };
    date = "2024-03-01";
  };
  wezterm = {
    pname = "wezterm";
    version = "22424c3280cb21af43317cb58ef7bc34a8cbcc91";
    src = fetchgit {
      url = "https://github.com/wez/wezterm";
      rev = "22424c3280cb21af43317cb58ef7bc34a8cbcc91";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-EQb0gNAb98e4IFwBv5XODtq9Er519wM/h5EglD8Lrhc=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wezterm-22424c3280cb21af43317cb58ef7bc34a8cbcc91/Cargo.lock;
      outputHashes = {
        "xcb-imdkit-0.3.0" = "sha256-fTpJ6uNhjmCWv7dZqVgYuS2Uic36XNYTbqlaly5QBjI=";
      };
    };
    date = "2024-02-26";
  };
  whitesur-gtk-theme = {
    pname = "whitesur-gtk-theme";
    version = "5a52172d2f27437555cc58c7dad15d06af74553d";
    src = fetchgit {
      url = "https://github.com/vinceliuice/WhiteSur-gtk-theme";
      rev = "5a52172d2f27437555cc58c7dad15d06af74553d";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-9HYsORTd5n0jUYmwiObPZ90mOGhR2j+tzs6Y1NNnrn4=";
    };
    date = "2024-02-26";
  };
}
