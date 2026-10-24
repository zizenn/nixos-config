{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, inputs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      home.packages = with pkgs; [
        feh
        obsidian
        pandoc
        vesktop
        vlc
        zathura
        inputs.zen-browser.packages.${system}.default
      ];
    };
}
