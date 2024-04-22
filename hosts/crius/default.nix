{ lib, pkgs, ... }: {
  imports = [
    ../../modules/core
    ../../home/gge
  ];

  home-manager.users.gge = { config, ... }: {
    home.sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
  };

  nix = {
    gc.automatic = true;
    linux-builder = {
      enable = true;
      ephemeral = true;
      config = { ... }: {
        # imports = [ ../../modules/core/nix.nix ];
        _module.args.hostType = "nixos";
        virtualisation.host.pkgs = lib.mkForce (pkgs.extend (final: _: {
          nix = final.nixVersions.unstable;
        }));
      };
      maxJobs = 4;
      protocol = "ssh-ng";
    };
    settings = {
      max-substitution-jobs = 20;
      trusted-users = [ "gge" ];
    };
  };

  users.users.gge = {
    uid = 504;
    gid = 20;
  };
}
