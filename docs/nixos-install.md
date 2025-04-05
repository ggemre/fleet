# Installing NixOS

This guide will walk you through setting up and installing NixOS on a _new_ machine not found in `hosts/`.
For reinstalling NixOS on an existing host, see [nixos-reinstall](./nixos-reinstall.md).

# Manual method

---

<!--TODO: make automatic installation script-->

### 1. Create a new directory in `hosts/`

Have the flake ready by cloning it.

```sh
git clone https://github.com/ggemre/fleet.git
cd fleet
```

>[!NOTE]
> `<HOSTNAME>` should be the hostname of your new host.
> See [hostnames](./hostnames.md) for information on selecting the hostname.
>
> `<INSTALLED_VERSION>` should be whatever version of NixOS you downloaded, such as 24.11.
<!--TODO: make hostnames page-->

```sh
touch ./hosts/<HOSTNAME>/default.nix
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

### 4. Set up hardware-configuration.nix

Create the hardware-configuration.nix file and import it into the `default.nix` file that we created earlier.

```sh
nixos-generate-config --no-filesystems --root /tmp
cp /tmp/nixos/hardware-configuration.nix ./hosts/<HOSTNAME>/hardware-configuration.nix
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

### 5. (optional) Add a new user

We can skip this step and use an existing user from `./home/`.

If we want to create a new user, create a new directory.

>[!NOTE]
> `<USER>` should be the name of the user we wish to add.

```sh
touch ./home/<USER>/default.nix
```

Set the file contents to the following for now:

```nix
{
  lib,
  system,
  ...
}:
let
  user = "<USER>";
  homeDir = if lib.strings.hasSuffix "darwin" system
            then "/Users/${user}" # nix-darwin home directory
            else "/home/${user}"; # nixos home directory
in {
  imports = [
    # add new modules from the current directory or existing modules from ../shared/
  ];

  home = {
    username = user;
    homeDirectory = lib.mkForce homeDir; # We mkForce to override users.users.${user}.home since this one has system check

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
```

### 6. Add the machine configuration output in `flake.nix`

In the outputs of `flake.nix`, add a new invocation of our `mkNixosSystem` function.

```nix
nixosConfigurations = {
      test = builders.mkNixosSystem {
        user = "<USER>"; # set to the user (see step 5)
        hostname = "<HOSTNAME>"; # set to the hostname (see step 1)
        system = "<SYSTEM>"; # set to the system (x86_64-linux or aarch64-linux)
      };
    };
```

We are still on the installation medium, so to record our changes, push to github.

```sh
git add .
git commit -m "feat(<HOSTNAME>): add new host"
git push
```
<!--TODO: setting up git and auth with GitHub...-->

### 7. Install NixOS

Now, installing NixOS is easy.

```sh
nixos-install
reboot
```

# Automatic method

---

_TODO...._

I'm going to add a script some day... ᶻ 𝗓 𐰁 .ᐟ

