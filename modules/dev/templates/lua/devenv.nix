# Copy to your Lua project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Open nvim from inside the shell and lua_ls / stylua / selene
# resolve from this shell's PATH.
{ pkgs, ... }:
{
  languages.lua.enable = true;

  packages = with pkgs; [
    lua-language-server # also bundled by languages.lua; listed so it's grep-able
    stylua
    selene
  ];
}
