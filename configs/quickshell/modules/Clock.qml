import QtQuick
import "../colors.js" as Colors

Text {
    id: clock

    property string timeStr: Qt.formatTime(new Date(), "hh:mm")

    text: timeStr
    color: Colors.onSurface
    font.pixelSize: 14
    font.weight: Font.Medium
    font.family: "monospace"

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clock.timeStr = Qt.formatTime(new Date(), "hh:mm")
    }
}
