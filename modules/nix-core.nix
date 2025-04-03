{
  pkgs,
  lib,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nix;
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  nix.settings = {
    sandbox = true;
    extra-sandbox-paths = [
      # TODO: determine what happens if path doesn't exist (for nixos/darwin interop)
      # "/System/Library/Frameworks"
      # "/System/Library/PrivateFrameworks"
      # "/usr/lib"
      # "/private/tmp"
      # "/private/var/tmp"
      # "/usr/bin/env"
    ];

    # Disable auto-optimise-store because of this issue:
    #   https://github.com/NixOS/nix/issues/7273
    # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
    auto-optimise-store = false;
  };
}
