{lib, ...}: {
  nixos.modules.base = {
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eyboard*", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eypad*", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Mm]ouse*", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Hh]id*", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Tt]ouchpad*", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="input", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd*", SUBSYSTEMS=="usb", ATTR{queue/scheduler}="bfq"
      ACTION=="change", SUBSYSTEM=="block", KERNEL=="sd*", SUBSYSTEMS=="usb", ATTR{queue/scheduler}="bfq"
    '';
  };
}
