# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  pkgs,
  lib,
  ...
}: {
  #boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  #boot.initrd.kernelModules = ["dm-snapshot"];
  #boot.kernelModules = ["kvm-amd"];
  #boot.extraModulePackages = [];

  services.fstrim.enable = true;

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs"];

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/9785f98d-e75e-4061-acbf-8ec99c413416";

  fileSystems = let
    commonOptions = ["rw" "compress=zstd:3" "space_cache=v2" "noatime" "discard=async" "ssd"];
    commonDevice = "/dev/disk/by-uuid/e3349e18-ab60-4986-9572-ae21623de113";
    commonFsType = "btrfs";
  in {
    "/boot" = {
      device = "/dev/disk/by-uuid/C0C6-0498";
      fsType = "vfat";
    };
    "/" = {
      device = commonDevice;
      fsType = commonFsType;
      options = commonOptions ++ ["subvol=root"];
    };
    "/home" = {
      device = commonDevice;
      fsType = commonFsType;
      options = commonOptions ++ ["subvol=home"];
      neededForBoot = true;
    };
    "/nix" = {
      device = commonDevice;
      fsType = commonFsType;
      options = commonOptions ++ ["subvol=nix"];
    };
    "/persist" = {
      device = commonDevice;
      fsType = commonFsType;
      options = commonOptions ++ ["subvol=persist"];
      neededForBoot = true;
    };
    "/var/log" = {
      device = commonDevice;
      fsType = commonFsType;
      options = commonOptions ++ ["subvol=log"];
      neededForBoot = true;
    };
    "/Stuff" = {
      device = "/dev/disk/by-uuid/01D95CE318FF5AE0";
      fsType = "ntfs";
      options = ["uid=1000" "gid=100" "rw" "user" "exec" "umask=000" "nofail"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/19df1bff-72e7-4694-ac01-37cc8ac42281";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nix.settings.max-jobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u22n.psf.gz";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
