{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./persist.nix

    # Shared Configuration
    ../shared/configuration.nix
  ];

  boot = {
    zfs.enableUnstable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = ["zfs" "ntfs"];
  };

  hardware.bluetooth.enable = true;

  # OpenGL
  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";
  boot = {
    initrd.kernelModules = ["amdgpu"];
    kernelParams = ["amd_pstate=passive" "initcall_blacklist=acpi_cpufreq_init"];
    kernelModules = ["amd-pstate"];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
    };
  };

  programs = {
    gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    hyprland.enable = true;
  };

  # TLP For Laptop
  services = {
    tlp.enable = true;
    tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";

      # https://linrunner.de/en/tlp/docs/tlp-faq.html#battery
      # use "tlp fullcharge" to override temporarily
      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;
      START_CHARGE_THRESH_BAT1 = 85;
      STOP_CHARGE_THRESH_BAT1 = 90;
    };

    greetd = {
      enable = true;

      settings = {
        default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'Hyprland'";

        initial_session = {
          command = "Hyprland";
          user = "ludovico";
        };
      };
    };

    xserver = {
      enable = true;
      layout = "us"; # Configure keymap
      libinput.enable = true;
      deviceSection = ''
        Option "TearFree" "true"
      '';

      displayManager = {
        lightdm.enable = false;
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = lib.mkForce false;
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = ["10.66.66.2/32" "fd42:42:42::2/128"];
      dns = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
      privateKeyFile = "/persist/wireguard/wireguardKey";

      peers = [
        {
          publicKey = "EpF2DZEMP+pnw+NdI4UkAW5QQZAeILzH4XnmAroeZgw=";
          presharedKeyFile = "/persist/wireguard/presharedKey";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "3.25.226.114:50412";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # Remove Bloat
  documentation.nixos.enable = lib.mkForce false;
}
