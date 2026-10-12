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

  # Backlight / media-key helpers and XWayland support for the session.
  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    xwayland-satellite
    libnotify
  ];

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
