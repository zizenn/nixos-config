{ config, pkgs, lib, ... }:

let
  # Path to your lua config directory (relative to this file)
  luaConfigDir = ./nvim;

  # Auto-discover all .lua files in a given directory (non-recursive)
  luaFilesIn =
    dir:
    let
      entries = builtins.readDir dir;
    in
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) entries;

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
  xdg.configFile = lib.mkMerge [
    # Main init.lua
    {
      "nvim/init.lua".source = luaConfigDir + "/init.lua";
    }

    # Config files - manually list subdirectories
    (luaConfigEntries (luaConfigDir + "/lua/config") "lua/config")

    # Auto-discover plugin configs
    (luaConfigEntries (luaConfigDir + "/lua/plugins") "lua/plugins")
  ];
}