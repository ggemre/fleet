{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["ahci" "ohci_pci" "ehci_pci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    loader.grub.enable = true;
  };

  boot.initrd.systemd = {
    services.rollback-zroot-local-root = {
      after = ["zfs-import-zroot.service"];
      wantedBy = ["initrd.target"];
      before = ["sysroot.mount"];

      path = [pkgs.zfs];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        zfs rollback -r zroot/local/root@blank && echo "  >> >> rollback complete << <<"
      '';
    };
  };
  boot.supportedFilesystems = ["zfs"];
  boot.loader.grub.zfsSupport = true;
  boot.initrd.supportedFilesystems = ["zfs"];
  networking.hostId = "143af453"; # ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine

  boot.zfs.devNodes = "/dev/disk/by-id";
  boot.zfs.forceImportRoot = false;

  systemd.tmpfiles.rules = [
    "d /persist/home/gge 0700 gge users -" # hm impermanence
  ];

  networking.useDHCP = true;
  networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
