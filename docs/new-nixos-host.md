# Setting up and Installing a New NixOS Host

# Manual method

---

<!--TODO: make automatic installation script-->

### 1. Create a new directory in `hosts/`

>[!NOTE]
> `<HOSTNAME>` should be the hostname of your new host.
> See [hostnames](./hostnames.md) for information on selecting the hostname.
>
> `<INSTALLED_VERSION>` should be whatever version of NixOS you downloaded, such as 24.11.
<!--TODO: make hostnames page-->

```sh
mkdir -p ./hosts/<HOSTNAME>/default.nix
```

Copy the following nix code and paste it into that `./hosts/<HOSTNAME>/default.nix` file:

```nix
{
  lib,
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./disk-config.nix
  ];

  users.users."${user}" = {
    home = "/home/${user}";
    description = user;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs.zsh.enable = true;

  system.stateVersion = "<INSTALLED_VERSION>";
}
```

### 2. Choose a disko layout

We will use `disko` to provision the filesystem. This is only done once before installing NixOS.

>[!NOTE]
> `<DEVICE_NAME>` should be the name of the device you will install NixOS to.
> Find the name by running `lsblk`.
> For example, replace the placeholder with /dev/sda.

<!--TODO: create disko directory-->
Choose an availible disk layout from `./disko/`, or just create a file called `disk-config.nix` with the following contents:

```nix
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "<DEVICE_NAME>";
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
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
```

### 3. Run disko to partition, format and mount the filesystem

From the `./hosts/<HOSTNAME>/` directory, run the following command.

```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disk-config.nix
```

### 4. Install NixOS

Create the hardware-configuration.nix file and import it into the `default.nix` file that we created earlier.

```sh
nixos-generate-config --no-filesystems --root .
```

We include the `--no-filesystems` flag since disko manages our filesystems now.

```nix
...  
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
...
```

Now, installing NixOS is easy.

```sh
nixos-install
reboot
```

# Automatic method

_TODO...._

