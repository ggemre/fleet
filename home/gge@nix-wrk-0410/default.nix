{
  lib,
  pkgs,
  system,
  ...
}: let
  user = "gge";
in {
  imports = [
    (import ../../modules/home/user.nix {inherit user system lib;})

    ../../modules/home/shell/zsh.nix
    ../../modules/home/shell/starship.nix
    ../../modules/home/shell/direnv.nix
    ../../modules/home/cli/eza.nix
    ../../modules/home/cli/git.nix
    ../../modules/home/cli/cliphist.nix
    ../../modules/home/terminal/ghostty.nix
    ../../modules/home/tui/helix.nix
    ../../modules/home/tui/yazi.nix
    ../../modules/home/browser/firefox.nix
    ../../modules/home/browser/brave.nix
    ../../modules/home/graphical/wofi.nix

    ../../modules/home/graphical/hypr
  ];

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 25;
    };

    packages = with pkgs; [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      bat
      just
      wbg
      wl-clipboard
      wtype

      # macbook
      brightnessctl
      alsa-utils
    ];
  };
}
