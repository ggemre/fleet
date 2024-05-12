{ config, self', pkgs, inputs', system, ... }:
{
  default = pkgs.mkShell {
    name = "fleet";

    nativeBuildInputs = with pkgs; [
      # Nix
      # inputs'.agenix.packages.${system}.default
      inputs'.agenix.packages.x86_64-linux.default
      # deploy-rs.deploy-rs
      nil
      nix-melt
      nix-output-monitor
      nix-tree
      nixpkgs-fmt
      self'.packages.cachix
      self'.packages.nix-fast-build
      statix

      # GitHub Actions
      # act
      # actionlint
      # python3Packages.pyflakes
      # shellcheck

      # Misc
      jq
      pre-commit
      rage
    ];
    shellHook = ''
      ${config.pre-commit.installationScript}
    '';
  };
}
