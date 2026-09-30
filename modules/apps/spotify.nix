{ ... }: {
  homeManager.modules.base =
    { pkgs, inputs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in
    {
      imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

      programs.spicetify = {
        enable = true;
        wayland = true;
        windowManagerPatch = true;

        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";

        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
          beautifulLyrics
          fullAppDisplay
          seekSong
          showQueueDuration
        ];

        enabledCustomApps = with spicePkgs.apps; [
          marketplace
          lyricsPlus
          newReleases
        ];
      };
    };
}
