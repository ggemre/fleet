{
  theme,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = ./theme/${theme}.yaml;
    fonts = {
      sansSerif = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
    };
  };
}
