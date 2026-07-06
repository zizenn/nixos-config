{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sakif";
        email = "zizenn@proton.me";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
