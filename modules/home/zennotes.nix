{ config, pkgs, ... }:

{
  xdg.configFile = {
    "zennotes/themes/matugen/manifest.json".text = builtins.toJSON {
      name = "Matugen";
      author = "matugen";
      description = "Material You colors generated from wallpaper";
      modes = "dark";
    };
  };
}
