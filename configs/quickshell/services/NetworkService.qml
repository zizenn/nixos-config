import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property string ssid: ""
    property int strength: 0
    property bool connected: false
    property bool enabled: true
    property var availableNetworks: []
    property string connectStatus: ""

    property Process statusProc: Process {
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

    property Process scanProc: Process {
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY", "dev", "wifi", "list"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var parts = data.split(":")
                if (parts.length >= 3) {
                    root.availableNetworks = root.availableNetworks.concat([{
                        ssid: parts[0],
                        signal: parseInt(parts[1]),
                        security: parts.slice(2).join(":")
                    }])
                }
            }
        }
    }

    property Process connectProc: Process {
        command: []
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                root.connectStatus = data
            }
        }
        onExited: {
            root.connectStatus = "done"
        }
    }

    property Process toggleProc: Process {
        command: []
        running: false
        onExited: {
            poll()
        }
    }

    property Timer pollTimer: Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: root.poll()
    }

    Component.onCompleted: poll()

    function poll() {
        statusProc.running = true
    }

    function scan() {
        root.availableNetworks = []
        scanProc.running = true
    }

    function connectToNetwork(ssid, password) {
        var cmd = ["nmcli", "dev", "wifi", "connect", ssid]
        if (password) {
            cmd.push("password", password)
        }
        connectProc.command = cmd
        connectProc.running = true
    }

    function setEnabled(en) {
        var cmd = en ? "nmcli radio wifi on" : "nmcli radio wifi off"
        toggleProc.command = ["bash", "-c", cmd]
        toggleProc.running = true
    }
}
