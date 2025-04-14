{
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    # shellAliases = {
    #   ls = "eza";
    #   cat = "bat";
    #   grep = "rg";
    # };

    shellAliases = {
      ls =
        if lib.hasAttr "eza" pkgs
        then "eza"
        else "ls";
      cat =
        if lib.hasAttr "bat" pkgs
        then "bat"
        else "cat";
      grep =
        if lib.hasAttr "ripgrep" pkgs
        then "rg"
        else "grep";
    };

    # sessionVariables = {
    #   # For nix-darwin bug with setting path: https://github.com/NixOS/nix/issues/2982
    #   NIX_PATH = "$HOME/.nix-defexpr/channels";
    # };

    # initExtra = ''
    #   eval "$(direnv hook zsh)"
    # '';
  };
}
