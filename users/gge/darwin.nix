{ pkgs, ... }: {
  # home-manager.users.gge = {
  #   imports = [
  #     ./graphical
  #     ./trusted
  #   ];
  #   programs.git.extraConfig.gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  # };

  users.users.gge = {
    createHome = true;
    description = "Gage Moore";
    home = "/Users/gge";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
