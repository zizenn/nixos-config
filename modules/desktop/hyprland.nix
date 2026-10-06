{ ... }: {
  nixos.modules.base = { pkgs, inputs, ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    services.displayManager.ly.enable = true;

    # ScrollOverview plugin (niri-style scrollable overview), built against
    # the same Hyprland as above (inputs.hyprland.follows). Load it from your
    # own hyprland.conf with:
    #   plugin = /run/current-system/sw/lib/libscrolloverview.so
    environment.systemPackages = [
      inputs.scrolloverview.packages.${pkgs.stdenv.hostPlatform.system}.scrolloverview
    ];

    # Hyprland's binary cache, so you don't build Hyprland from source.
    nix.settings = {
      extra-substituters = [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  homeManager.modules.base = { pkgs, ... }: {
    home.packages = with pkgs; [
      quickshell
      # swaylock kept as emergency fallback; idle+lock is handled by Noctalia
      swaylock
      wl-clipboard
    ];

    # Declarative Hyprland (Lua) config — source lives in ./hypr/.
    xdg.configFile."hypr" = {
      source = ./hypr;
      recursive = true;
    };
  };
}
