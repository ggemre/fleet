{
  impermanence,
  user,
  ...
}: {
  imports = [impermanence.homeManagerModules.impermanence];

  home.persistence."/persist/home/${user}" = {
    directories = [
      ".config/dconf"
      ".config/direnv"
      ".config/git"
      ".config/helix"
      ".config/yazi"
      ".ssh"
      ".local/share/direnv"
    ];
    files = [
      ".zsh_history"
      ".zshrc"
    ];
    allowOther = true;
  };
}
