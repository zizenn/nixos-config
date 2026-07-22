{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "zizenn";
        email = "zizenn.69@gmail.com";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
