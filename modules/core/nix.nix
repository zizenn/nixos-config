{ ... }:
{
  nix = {
    optimise = {
      automatic = true;
      dates = [ "04:00" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;      builders-use-substitutes = true;
      connect-timeout = 5;
      cores = 0;
      keep-failed = false;
      log-lines = 25;
      max-free = 20000000000;
      max-jobs = "auto";
      min-free = 5000000000;
      sandbox = false;
      tarball-ttl = 86400;
      trusted-users = [
        "root"
        "@wheel"
        "zizenn"
      ];
      # Hyprland's binary cache, so you don't build Hyprland from source.
      extra-substituters = [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
