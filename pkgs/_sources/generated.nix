# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "eb7c43d11abc157f97d032018115c9f7b04ca4de";
    src = fetchgit {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme";
      rev = "eb7c43d11abc157f97d032018115c9f7b04ca4de";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-gpUrma8XjAnHULRmD5RRVVZJNvxFrIEyGQLx6oEE9D4=";
    };
    date = "2024-01-14";
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
  waybar = {
    pname = "waybar";
    version = "6e12f8122347ae279ae0fa1923acd6b908fa769c";
    src = fetchgit {
      url = "https://github.com/alexays/waybar";
      rev = "6e12f8122347ae279ae0fa1923acd6b908fa769c";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-YG/4LeOPtc0u/bLbFQ4yCyLSatrzPfE3a9X1+k8Ttpc=";
    };
    date = "2024-01-17";
  };
  wezterm = {
    pname = "wezterm";
    version = "c4970b7fc8f2eae994b80e95154f5fee0e3c7771";
    src = fetchgit {
      url = "https://github.com/wez/wezterm";
      rev = "c4970b7fc8f2eae994b80e95154f5fee0e3c7771";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-mE9Jbmou286nxY60roA5VmXzTofKQh2hB9Wm2u+PIL8=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wezterm-c4970b7fc8f2eae994b80e95154f5fee0e3c7771/Cargo.lock;
      outputHashes = {
        "xcb-1.2.1" = "sha256-zkuW5ATix3WXBAj2hzum1MJ5JTX3+uVQ01R1vL6F1rY=";
        "xcb-imdkit-0.2.0" = "sha256-L+NKD0rsCk9bFABQF4FZi9YoqBHr4VAZeKAWgsaAegw=";
      };
    };
    date = "2024-01-21";
  };
}
