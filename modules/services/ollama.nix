{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "10.3.0";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1030";
      };
    };
  };
}
