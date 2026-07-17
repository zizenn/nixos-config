{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  wrapGAppsHook3,
  copyDesktopItems,
  makeDesktopItem,

  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  libdrm,
  libGL,
  libgbm,
  libnotify,
  libpulseaudio,
  libuuid,
  libxkbcommon,
  nspr,
  nss,
  pango,
  systemd,
  wayland,
  libx11,
  libxcb,
  libxcomposite,
  libxcursor,
  libxdamage,
  libxext,
  libxfixes,
  libxi,
  libxrandr,
  libxrender,
  libxscrnsaver,
  libxtst,

  commandLineArgs ? "",
}:
let
  releaseData = lib.importJSON ./release-data.json;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zennotes-desktop";
  inherit (releaseData) version;

  src = fetchurl {
    url = "https://github.com/ZenNotes/zennotes/releases/download/v${finalAttrs.version}/ZenNotes-${finalAttrs.version}-linux-x64.tar.gz";
    hash = releaseData.desktopHash;
  };

  sourceRoot = "ZenNotes-${finalAttrs.version}-linux-x64";

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libgbm
    libuuid
    libxkbcommon
    nspr
    nss
    pango
    stdenv.cc.cc
    libx11
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxscrnsaver
    libxtst
    libxcb
  ];

  runtimeDependencies = [
    (lib.getLib systemd)
    libGL
    libnotify
    libpulseaudio
    wayland
  ];

  dontConfigure = true;
  dontBuild = true;
  dontWrapGApps = true;

  installPhase = ''
    runHook preInstall

    rm -f chrome-sandbox

    mkdir -p $out/share/zennotes
    cp -r . $out/share/zennotes

    for icon in $out/share/zennotes/resources/arch-extras/icons/*.png; do
      size="$(basename "$icon" .png)"
      install -Dm644 "$icon" "$out/share/icons/hicolor/$size/apps/${finalAttrs.pname}.png"
    done

    makeWrapper $out/share/zennotes/ZenNotes $out/bin/${finalAttrs.pname} \
      "''${gappsWrapperArgs[@]}" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto}}" \
      ${lib.optionalString (commandLineArgs != "") "--add-flags ${lib.escapeShellArg commandLineArgs}"}

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = finalAttrs.pname;
      desktopName = "ZenNotes";
      exec = "${finalAttrs.pname} %U";
      icon = finalAttrs.pname;
      comment = "Keyboard-first local Markdown notes";
      categories = [
        "Office"
        "Utility"
        "TextEditor"
      ];
      startupWMClass = "ZenNotes";
      mimeTypes = [
        "text/markdown"
        "x-scheme-handler/zennotes"
      ];
    })
  ];

  meta = {
    description = "Keyboard-first local Markdown notes with Vim motions, diagrams, and MCP integration (prebuilt binary)";
    homepage = "https://zennotes.org/";
    changelog = "https://github.com/ZenNotes/zennotes/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = finalAttrs.pname;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
})
