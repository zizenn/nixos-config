{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "zizenn";
          email = "zizenn.69@gmail.com";
        };
        core.editor = "nvim";
      };
    };
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "sakif";
          email = "zizenn.69@gmail.com";
        };
        ui.default-editor = "nvim";
      };
    };
    home.packages = with pkgs; [
      gh lazygit lazyjj devenv cargo cppman jq
      nix-search-cli nodejs_26 python3 socat uv
    ];
  };
}
