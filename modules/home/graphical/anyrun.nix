{
  anyrun,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        # randr
        rink
        symbols
        # shell
        # stdin
        translate
        # websearch
      ];
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      width = {fraction = 0.3;};
      layer = "overlay";
      hideIcons = true;
      hidePluginInfo = true;
      maxEntries = 15;
      showResultsImmediately = false;
      ignoreExclusiveZones = false;
      closeOnClick = true;
    };
  };
}
