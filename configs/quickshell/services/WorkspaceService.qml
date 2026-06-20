import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property int activeId: 1
    property var workspaces: []

    function update() {
        activePoll.running = true
        wsPoll.running = true
    }

    property Process activePoll: Process {
        command: ["hyprctl", "activeworkspace"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var m = data.match(/workspace ID (\d+)/)
                if (m) root.activeId = parseInt(m[1])
            }
        }
    }

    property Process wsPoll: Process {
        command: ["hyprctl", "workspaces"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var m = data.match(/workspace ID (\d+)/)
                if (m) {
                    var id = parseInt(m[1])
                    if (wsPoll.seen.indexOf(id) === -1)
                        wsPoll.seen.push(id)
                }
            }
        }
        property var seen: []
        onExited: {
            var ids = seen.sort(function(a, b) { return a - b })
            var out = []
            for (var i = 0; i < ids.length; i++)
                out.push({ id: ids[i], name: String(ids[i]) })
            root.workspaces = out
            seen = []
        }
    }

    property Timer poller: Timer {
        interval: 300
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.update()
    }

    property Process dispatchProc: Process { running: false }

    function switchTo(id) {
        dispatchProc.command = ["hyprctl", "dispatch", "workspace", String(id)]
        dispatchProc.running = true
    }
}
