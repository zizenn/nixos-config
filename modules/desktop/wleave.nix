{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: let
    iconsDir = "${pkgs.wleave}/share/wleave/icons";
  in {
    xdg.configFile."wleave/layout.json".text = builtins.replaceStrings
      ["__ICONS__"] [iconsDir]
      (builtins.readFile ./wleave/layout.json);
    home.packages = with pkgs; [wleave wl-clipboard];
  };
}
