{
  description = "zizenn's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wlctl.url = "github:aashish-thapa/wlctl";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      lib = pkgs.lib;

      shardDevLibs = with pkgs; [
        libGL
        libx11
        libxcb
        libpulseaudio
        webkitgtk_4_1
        gtk3
        gdk-pixbuf
        librsvg
        libsoup_3
        openssl
        glib-networking
        gsettings-desktop-schemas
        cairo
        pango
        atk
        at-spi2-atk
        gdk-pixbuf
        freetype
        fontconfig
        dbus
      ];

    in
    {
      nixosConfigurations.nix-port = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./modules/system/configuration.nix
        ];
      };

      devShells.x86_64-linux = {
        shard = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            rustc
            rustfmt
            pkg-config
            openssl
            webkitgtk_4_1
            gtk3
            libsoup_3
            nodejs
          ];

          shellHook = ''
            export LD_LIBRARY_PATH="${lib.makeLibraryPath shardDevLibs}:$LD_LIBRARY_PATH"
            export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            export NIX_SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
          '';
        };

        default = pkgs.mkShell {
          packages = with pkgs; [
            just
            curl
            jq
          ];
        };
      };
    };
}
