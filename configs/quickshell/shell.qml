import Quickshell
import Quickshell.Io
import QtQuick
import "./services" as Services

ShellRoot {
    Services.AppLauncherService { id: launcherSvc }

    property Process triggerProc: Process {
        command: ["bash", "-c",
            "if [ -f /tmp/quickshell-launcher ]; then rm /tmp/quickshell-launcher && echo 1; else echo 0; fi"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.trim() === "1") {
                    if (launcherWin.visible) {
                        launcherWin.hide()
                        launcherSvc.query = ""
                    } else {
                        launcherWin.openPopup()
                    }
                }
            }
        }
    }

    property Timer poller: Timer {
        interval: 150
        running: true
        repeat: true
        onTriggered: {
            if (!triggerProc.running)
                triggerProc.running = true
        }
    }

    DynamicIslandBar {
        launcherOpen: launcherWin.visible
    }

    LauncherWindow {
        id: launcherWin
        launcherModel: launcherSvc
        onCloseRequested: {
            launcherWin.hide()
            launcherSvc.query = ""
        }
    }
}
