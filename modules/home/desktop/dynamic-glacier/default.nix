{
  config,
  pkgs,
  ...
}:

let
  src = pkgs.fetchFromGitHub {
    owner = "mavxa";
    repo = "DynamicGlacier";
    rev = "d3487f52f64fb97abf016c1834975be37a3cb9c6";
    hash = "sha256-pG9TxDpwoqL3F1vwuXO2TsHZA+Sj5R573AMmfc+eufU=";
  };

  patched = pkgs.runCommand "dynamic-glacier-patched" {
    nativeBuildInputs = [ pkgs.python3 ];
  } ''
    cp -r ${src}/quickshell $out
    chmod -R +w $out

    python3 << PYEOF
qml = "$out/modules/dynamicGlacier/DynamicGlacier.qml"

with open(qml) as f:
    content = f.read()

content = content.replace(
    "import Quickshell.Hyprland\n",
    "",
)

content = content.replace(
    '    readonly property string fontFamily: "Noto Sans"',
    '    readonly property string fontFamily: "Noto Sans"\n    property string niriFocusedOutput: ""',
)

content = content.replace(
    """    function focusedScreen() {
        const focusedMonitor = Hyprland.focusedMonitor;

        if (focusedMonitor) {
            for (let i = 0; i < Quickshell.screens.length; i += 1) {
                if (Quickshell.screens[i].name === focusedMonitor.name)
                    return Quickshell.screens[i];
            }
        }

        return Quickshell.screens.length > 0 ? Quickshell.screens[0] : null;
    }""",
    """    function focusedScreen() {
        for (let i = 0; i < Quickshell.screens.length; i += 1) {
            if (Quickshell.screens[i].name === root.niriFocusedOutput)
                return Quickshell.screens[i];
        }

        return Quickshell.screens.length > 0 ? Quickshell.screens[0] : null;
    }""",
)

content = content.replace(
    """    Process {
        id: btSettingsProc
    }""",
    """    Process {
        id: btSettingsProc
    }

    Process {
        id: niriFocusedOutputProc

        stdout: StdioCollector {
            onStreamFinished: {
                const name = text.trim();
                if (name !== "")
                    root.niriFocusedOutput = name;
            }
        }
    }

    Timer {
        interval: 500
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            if (!niriFocusedOutputProc.running)
                niriFocusedOutputProc.exec(["niri", "msg", "focused-output"]);
        }
    }""",
)

with open(qml, "w") as f:
    f.write(content)
PYEOF
  '';

  launcher = pkgs.writeShellScriptBin "dynamic-glacier" ''
    exec ${pkgs.quickshell}/bin/quickshell --config DynamicGlacier "$@"
  '';
in
{
  home.packages = with pkgs; [
    quickshell
    playerctl
    upower
    psmisc
    pulseaudio
    noto-fonts
    launcher
  ];

  xdg.configFile."quickshell/DynamicGlacier".source = patched;
}
