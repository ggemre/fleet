{
  pkgs,
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel" "wl"];
    extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
    loader = {
      # grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0; # mash spacebar to select a previous generation
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = [
        # https://github.com/adi1090x/plymouth-themes
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })
      ];
    };
    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];
  };

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # slows down boot time and can catch up in session
  # systemd.services.NetworkManager-wait-online.enable = false; XXX: this breaks ly
  
  virtualisation.docker.enable = true;

  services = {
    pipewire.enable = false;
    pulseaudio.enable = true;
    libinput.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
