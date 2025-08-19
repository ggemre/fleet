{
  pkgs,
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./stylix.nix

    (import ../../modules/nixos/ly.nix {
      inherit pkgs;
    })

    inputs.nixos-hardware.nixosModules.apple-macbook-air-7
  ];

  users.users."${user}" = {
    home = "/home/${user}";
    description = user;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };

  programs.zsh.enable = true;

  time.timeZone = "Asia/Phnom_Penh";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
    ];
  };

  # Most users should never change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # https://mynixos.com/nixpkgs/option/system.stateVersion
  system.stateVersion = "25.05";
}
