{pkgs, ...}: let
  theme = "catppuccin-mocha";
in {
  stylix = {
    enable = true;
    base16Scheme = ../../theme/${theme}.yaml;
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets.plymouth.enable = false;
  };
}
