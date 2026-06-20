import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property string ssid: ""
    property int strength: 0
    property bool connected: false

    property Timer pollTimer: Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: root.poll()
    }

    property Process nmcliProc: Process {
        command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL", "dev", "wifi"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var parts = data.split(":")
                if (parts[0] === "yes") {
                    root.connected = true
                    root.ssid = parts[1] || ""
                    root.strength = parseInt(parts[2] || "0")
                }
            }
        }
        onExited: {
            if (!root.connected) {
                root.ssid = ""
                root.strength = 0
            }
        }
    }

    Component.onCompleted: poll()

    function poll() {
        nmcliProc.running = true
    }
}
