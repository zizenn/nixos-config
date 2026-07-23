{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    cppman
    jq
    nix-search-cli
    nodejs_26
    python3
    socat
    uv
  ];
}
