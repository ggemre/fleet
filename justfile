default:
  just --list

[linux]
[doc('Activate {{host}} without adding to boot list')]
[group('build')]
test host:
  sudo nixos-rebuild test --flake .#{{host}}

[linux]
[doc('Rebuild, activate, and boot list {{host}}')]
[group('build')]
switch host:
  sudo nixos-rebuild switch --flake .#{{host}}

[macos]
[doc('Rebuild, activate, and boot list {{host}}')]
[group('build')]
switch host:
  darwin-rebuild switch --flake .#{{host}}

[linux]
[doc('Build {{host}} to `./result`')]
[group('build')]
build host:
  nixos-rebuild build --flake .#{{host}}

[macos]
[doc('Build {{host}} to `./result`')]
[group('build')]
build host:
  darwin-rebuild build --flake .#{{host}}

[linux, macos]
[doc('Build an iso to ./result/iso')]
[group('build')]
iso image:
  nix build .#nixosConfigurations.{{image}}.config.system.build.isoImage # this took 38mins on my MacBook Air, leave this cmd to the GitHub runners PLEASE

[doc('Update all inputs (i.e. recreate the lock file from scratch)')]
[group('flake')]
update:
  nix flake update

[doc('Format the nix files in this repo')]
[group('flake')]
fmt:
  nix fmt .

[doc('Remove the symlinked build output at `./result`')]
[group('flake')]
clean:
  rm -rf result

[linux, macos]
[doc('Open a shell for developing this flake')]
[group('flake')]
shell:
  nix develop -c $SHELL

[doc('Show all versions of the current profile')]
[group('system')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[doc('Remove week old generations and unused derivations')]
[group('system')]
gc:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
  sudo nix store gc --debug

[linux]
[doc('Clear boot entries besides current profile for {{host}}')]
[group('system')]
prune host:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
  sudo /run/current-system/bin/switch-to-configuration boot # update boot menu
  sudo rm /nix/var/nix/profiles/system-*
  sudo nixos-rebuild boot --flake .#{{host}}

