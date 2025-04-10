{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
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

    experimental-features = ["nix-command" "flakes"];
    trusted-users = [ "@wheel" ];
  };
}
