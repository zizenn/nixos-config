{ config, pkgs, lib, ... }:

let
  # Path to your lua config directory (relative to this file)
  luaConfigDir = ./nvim;

  # Auto-discover all .lua files in a given directory (recursive)
  luaFilesIn =
    dir:
    let
      entries = builtins.readDir dir;
      luaFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) entries;
      subdirs = lib.filterAttrs (name: type: type == "directory") entries;
      recurse = lib.mapAttrs' (name: _: luaFilesIn (dir + "/${name}")) subdirs;
    in
    lib.mergeEqualOption luaFiles (lib.concatMap (x: x) (builtins.attrValues recurse));

  # Build xdg.configFile entries for every .lua file in a directory
  # targetDir is the destination path inside ~/.config/nvim/
  luaConfigEntries =
    sourceDir: targetDir:
    let
      files = luaFilesIn sourceDir;
    in
    lib.mapAttrs' (
      name: _: lib.nameValuePair "nvim/${targetDir}/${name}" { source = sourceDir + "/${name}"; }
    ) files;

in
{
  imports = [ ./packages.nix ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    # LSP servers and tools installed via nix (not mason)
    extraPackages = with pkgs; [
      # LSPs
      clang-tools
      lua-language-server
      nil

      # Formatters
      stylua

      # Debug
      lldb

      # Telescope dependencies
      ripgrep
      fd
      fzf
    ];
  };

  xdg.configFile = lib.mkMerge [
    # Main init.lua
    {
      "nvim/init.lua".source = luaConfigDir + "/init.lua";
    }

    # Config files
    (luaConfigEntries (luaConfigDir + "/lua/config") "lua/config")

    # Auto-discover plugin configs
    (luaConfigEntries (luaConfigDir + "/lua/plugins") "lua/plugins")
  ];
}
