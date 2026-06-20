import QtQuick

Text {
    id: clock

    property var colors: null
    property string timeStr: Qt.formatTime(new Date(), "h:mm AP")

    text: timeStr
    color: colors ? colors.cOnSurface : "#e2e2e9"
    font.pixelSize: 14
    font.weight: Font.Medium
    font.family: "monospace"

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clock.timeStr = Qt.formatTime(new Date(), "h:mm AP")
    }
}
