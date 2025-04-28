_: {
  fileSystems."/".neededForBoot = true;
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zroot = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };

    zpool.zroot = {
      type = "zpool";
      mountpoint = null;

      rootFsOptions = {
        acltype = "posixacl";
        atime = "off";
        compression = "lz4";
        mountpoint = "none";
        xattr = "sa";

        #encryption = "aes-256-gcm";
        #keyformat = "passphrase";
        #keylocation = "file:///tmp/secret.key";
        #keylocation = "promt";
      };

      options = {
        ashift = "12";
      };

      datasets = {
        "local/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          options.mountpoint = "legacy";
          postCreateHook = "zfs snapshot zroot/local/root@blank";
        };
        "local/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
          options.mountpoint = "legacy";
        };
        "safe/persist" = {
          type = "zfs_fs";
          mountpoint = "/persist";
          options.mountpoint = "legacy";
        };
      };
    };
  };
}
