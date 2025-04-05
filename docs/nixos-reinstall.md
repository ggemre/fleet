# Reinstalling NixOS

This guide will walk you through reinstalling NixOS on an _existing_ machine from `hosts/`.
For setting up and installing NixOS on a brand new machine, see [nixos-install](./nixos-install.md).

### 1. Clone this flake

<!--TODO: use remote github source instead of local repo-->
With the correct machine booted up with the NixOS installer, clone `fleet`. The location to which you clone the repository does not matter.

```sh
git clone https://github.com/ggemre/fleet.git
cd fleet
```

### 2. Partition, format and mount the disk

Use [disko](https://github.com/nix-community/disko) to setup the filesystems. Make sure to replace <HOSTNAME> with the name of the machine you will be
reinstalling NixOS on.

```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./hosts/<HOSTNAME>/disk-config.nix
```

The process will prompt you to confirm writing to disk. Type `yes` and wait for it to finish.

### 3. Install NixOS

Use `nixos-install` to finish the installation. As with before, replace <HOSTNAME> with the correct name of the machine.

```sh
sudo nixos-install --flake .#<HOSTNAME>
reboot
```

The installation process will confirm if you would like to add a number of extra-substituters and extra-trusted-public-keys. Agree to each one by typing `y`.
It will also allow you to input your root password.

### 4. Finish setting up your user

Once the system reboots, (make sure to remove the installation media within this time), login as root and set the user's password.
Make sure to replace <USER> with the _same_ username that is attributed to this machine as outlined in `flake.nix`.

```sh
passwd <USER>
exit
```

NixOS has been installed and the full system configuration has been reapplied.
