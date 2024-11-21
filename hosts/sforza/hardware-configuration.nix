# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  fileSystems."/home/airi/WinE" = {
    device = "/dev/disk/by-label/WinE";
    fsType = "ntfs";
    options = [
      "uid=1000"
      "gid=100"
      "rw"
      "user"
      "exec"
      "umask=000"
      "nofail"
    ];
  };

  fileSystems."/home/airi/Media" = {
    device = "/dev/disk/by-uuid/9f731a8a-1d76-4b74-ad60-cb2e245d4224";
    fsType = "bcachefs";
    options = [
      # Enable discard/TRIM support
      "discard"
      # foreground compression with zstd
      "compression=zstd"
      # background compression with zstd
      "background_compression=zstd"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/1cd8fb5d-e27e-4b3b-b9e2-be70b346afd7"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
