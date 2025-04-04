{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = true;
  networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
