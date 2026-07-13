{ config, lib, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-sandbox-paths = [ "/var/cache/ccache" ];
  };
}
