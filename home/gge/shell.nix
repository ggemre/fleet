_: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      grep = "rg";
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
