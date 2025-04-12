{pkgs, ...}: {
  # imports = [];

  environment.systemPackages = with pkgs; [
    gitMinimal
    curl
    helix
  ];

  programs.zsh.enable = true;

  # Most users should never change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # https://mynixos.com/nixpkgs/option/system.stateVersion
  system.stateVersion = "24.11";
}
