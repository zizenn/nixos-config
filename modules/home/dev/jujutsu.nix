{ pkgs, config, ... }: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "sakif";
        email = "zizenn.69@gmail.com";
      };
      ui = {
        default-editor = "nvim";
      };
    };
  };

  home.packages = with pkgs; [ lazyjj ];
}
