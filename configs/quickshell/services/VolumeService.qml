import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property real volume: 0.0
    property bool muted: false

    property Process proc: Process {
        command: ["bash", "-c", "while true; do wpctl get-volume @DEFAULT_AUDIO_SINK@; sleep 0.15; done"]
        running: true
        stdout: SplitParser {
            onRead: function(data) {
                var m = data.indexOf("MUTED") !== -1
                var match = data.match(/[0-9]+\.[0-9]+/)
                if (match) root.volume = parseFloat(match[0])
                root.muted = m
            }
        }
    }
}
