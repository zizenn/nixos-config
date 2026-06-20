import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property bool powered: false
    property int connectedCount: 0

    property Timer pollTimer: Timer {
        interval: 8000
        running: true
        repeat: true
        onTriggered: root.poll()
    }

    property Process btPoweredProc: Process {
        command: ["bluetoothctl", "show"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Powered: yes") !== -1) root.powered = true
                else if (data.indexOf("Powered: no") !== -1) root.powered = false
            }
        }
    }

    property Process btDevicesProc: Process {
        command: ["bluetoothctl", "devices", "Connected"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Device") === 0) btDevicesProc.deviceCount++
            }
        }
        property int deviceCount: 0
        onExited: {
            root.connectedCount = btDevicesProc.deviceCount
            btDevicesProc.deviceCount = 0
        }
    }

    Component.onCompleted: poll()

    function poll() {
        btPoweredProc.running = true
        btDevicesProc.running = true
    }
}
