import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property real volume: 0.0
    property real prevVolume: 0.0
    property bool muted: false
    property real lastChange: 0

    onVolumeChanged: {
        if (Math.abs(volume - prevVolume) > 0.005) {
            prevVolume = volume
            lastChange = Date.now()
        }
    }

    property Process proc: Process {
        command: ["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var v = 0.0
                var m = data.indexOf("MUTED") !== -1
                var match = data.match(/[0-9]+\.[0-9]+/)
                if (match) v = parseFloat(match[0])
                root.volume = v
                root.muted = m
            }
        }
    }

    property Timer pollTimer: Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            if (!proc.running)
                proc.running = true
        }
    }
}
