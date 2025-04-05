_: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # For improved hermeticism with homebrew,
      # zap uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # `brew install --cask`
    casks = [
      "arc"
      "zed"
      "virtualbox"
    ];
  };
}
