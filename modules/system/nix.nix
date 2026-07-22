{ config, lib, pkgs, ... }: {
  nix = {
    optimise = {
      automatic = true;
      dates = [ "04:00" ];
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      connect-timeout = 5;
      cores = 0;
      extra-sandbox-paths = [ "/var/cache/ccache" ];
      keep-failed = false;
      log-lines = 25;
      max-free = 20000000000;
      max-jobs = "auto";
      min-free = 5000000000;
      sandbox = false;
      tarball-ttl = 86400;
      trusted-users = [ "root" "@wheel" "zizenn" ];
    };
  };
}
