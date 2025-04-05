default:
  just --list

[linux]
[doc('Activate {{host}} without adding to boot list')]
[group('build')]
test host:
  nixos-rebuild test --flake .#{{host}}

[linux]
[doc('Rebuild, activate, and boot list {{host}}')]
[group('build')]
switch host:
  nixos-rebuild switch --flake .#{{host}}

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

[doc('Update all inputs (i.e. recreate the lock file from scratch)')]
[group('flake')]
update:
  nix flake update

[doc('Format the nix files in this repo')]
[group('flake')]
fmt:
  nix fmt

[doc('Remove the symlinked build output at `./result`')]
[group('flake')]
clean:
  rm -rf result

[doc('Show all versions of the current profile')]
[group('system')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[doc('Remove week old generations and remove unused `/nix/store` entries')]
[group('system')]
gc:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
  sudo nix store gc --debug

