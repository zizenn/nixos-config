{ ... }:
{
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ wiremix ];
    };
}
