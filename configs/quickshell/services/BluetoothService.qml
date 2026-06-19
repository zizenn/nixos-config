import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property bool powered: false
    property int connectedCount: 0

    Component.onCompleted: poll()

    Timer {
        interval: 8000
        running: true
        repeat: true
        onTriggered: root.poll()
    }

    function poll() {
        btPowered.running = true
        btDevices.running = true
    }

    Process {
        id: btPowered
        command: ["bluetoothctl", "show"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Powered: yes") !== -1) root.powered = true
                else if (data.indexOf("Powered: no") !== -1) root.powered = false
            }
        }
    }

    Process {
        id: btDevices
        command: ["bluetoothctl", "devices", "Connected"]
        running: false
        property int count: 0
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Device") === 0) btDevices.count++
            }
        }
        onExited: {
            root.connectedCount = btDevices.count
            btDevices.count = 0
        }
    }
}
