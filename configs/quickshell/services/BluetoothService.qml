import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property bool powered: false
    property bool discovering: false
    property int connectedCount: 0
    property var availableDevices: []
    property var connectedDevices: []
    property string connectStatus: ""

    property Process statusProc: Process {
        command: ["bluetoothctl", "show"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Powered: yes") !== -1) root.powered = true
                else if (data.indexOf("Powered: no") !== -1) root.powered = false
                if (data.indexOf("Discovering: yes") !== -1) root.discovering = true
                else if (data.indexOf("Discovering: no") !== -1) root.discovering = false
            }
        }
    }

    property Process devicesProc: Process {
        command: ["bluetoothctl", "devices"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Device ") === 0) {
                    var rest = data.substring(7)
                    var mac = rest.substring(0, 17)
                    var name = rest.substring(18)
                    root.availableDevices = root.availableDevices.concat([{
                        address: mac,
                        name: name,
                        connected: false
                    }])
                }
            }
        }
        onExited: {
            // Check connected status for each device
            root.refreshConnected()
        }
    }

    property Process connectedProc: Process {
        command: ["bluetoothctl", "devices", "Connected"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                if (data.indexOf("Device ") === 0) {
                    var rest = data.substring(7)
                    var mac = rest.substring(0, 17)
                    var name = rest.substring(18)
                    root.connectedDevices = root.connectedDevices.concat([{
                        address: mac,
                        name: name
                    }])
                }
            }
        }
        onExited: {
            root.connectedCount = root.connectedDevices.length
            // Update connected status in availableDevices
            var conn = {}
            for (var i = 0; i < root.connectedDevices.length; i++)
                conn[root.connectedDevices[i].address] = true

            var devs = root.availableDevices
            for (var j = 0; j < devs.length; j++) {
                devs[j].connected = conn[devs[j].address] === true
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
            root.refreshConnected()
        }
    }

    property Process toggleProc: Process {
        command: []
        running: false
        onExited: {
            root.poll()
        }
    }

    property Timer pollTimer: Timer {
        interval: 8000
        running: true
        repeat: true
        onTriggered: root.poll()
    }

    Component.onCompleted: poll()

    function poll() {
        statusProc.running = true
    }

    function refreshDevices() {
        availableDevices = []
        connectedDevices = []
        devicesProc.running = true
    }

    function refreshConnected() {
        connectedDevices = []
        connectedProc.running = true
    }

    function connectToDevice(address) {
        connectProc.command = ["bluetoothctl", "connect", address]
        connectProc.running = true
    }

    function disconnectDevice(address) {
        connectProc.command = ["bluetoothctl", "disconnect", address]
        connectProc.running = true
    }

    function setEnabled(en) {
        toggleProc.command = ["bluetoothctl", en ? "power" : "power", en ? "on" : "off"]
        toggleProc.running = true
    }

    function startDiscovery() {
        toggleProc.command = ["bluetoothctl", "scan", "on"]
        toggleProc.running = true
    }

    function stopDiscovery() {
        toggleProc.command = ["bluetoothctl", "scan", "off"]
        toggleProc.running = true
    }
}
