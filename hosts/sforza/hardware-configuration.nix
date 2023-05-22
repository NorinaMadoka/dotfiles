# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  services.fstrim.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d47b8ddb-16d4-464e-90a0-1d169f4da855";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/0783173e-f38d-4492-8039-08b4d3fa77a8";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d47b8ddb-16d4-464e-90a0-1d169f4da855";
    fsType = "btrfs";
    options = ["subvol=home"];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d47b8ddb-16d4-464e-90a0-1d169f4da855";
    fsType = "btrfs";
    options = ["subvol=nix"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/d47b8ddb-16d4-464e-90a0-1d169f4da855";
    fsType = "btrfs";
    options = ["subvol=persist"];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/d47b8ddb-16d4-464e-90a0-1d169f4da855";
    fsType = "btrfs";
    options = ["subvol=log"];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E27D-00C9";
    fsType = "vfat";
  };

  fileSystems."/Stuff" = {
    device = "/dev/disk/by-uuid/01D95CE318FF5AE0";
    fsType = "ntfs";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/592b2453-4980-4e93-a120-9e1b5ba25fbc";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  #networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
