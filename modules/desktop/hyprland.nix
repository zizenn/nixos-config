{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hyprland's binary cache, so you don't build Hyprland from source.
  nix.settings = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        quickshell
        wl-clipboard
      ];

      # Declarative Hyprland (Lua) config — source lives in ./hypr/.
      xdg.configFile."hypr" = {
        source = ./hypr;
        recursive = true;
      };

      # Session-wide env for the UWSM-managed session, so systemd user
      # services (not just Hyprland itself) see these. Mirrors ./hypr/modules/env.lua.
      xdg.configFile."uwsm/env".text = ''
        export XCURSOR_SIZE=18
        export HYPRCURSOR_SIZE=18
      '';
    };
}
