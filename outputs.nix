inputs: let
  inherit (inputs.nixpkgs) lib;

  collectModules = dir: let
    entries = builtins.readDir dir;
    names = builtins.attrNames entries;
    process = name: let
      path = dir + "/${name}";
    in
      if entries.${name} == "directory" then
        collectModules path
      else if entries.${name} == "regular" && lib.hasSuffix ".nix" name && !lib.hasPrefix "_" name then
        [(import path)]
      else
        [];
  in builtins.concatMap process names;

  modules = collectModules ./modules;

  evaluation = inputs.flake-parts.lib.evalFlakeModule {inherit inputs;} {
    imports = modules;
  };
in
  {inherit evaluation;} // evaluation.config.processedFlake
