import QtQuick
import "../colors.js" as Colors

Row {
    id: root

    property string wifiSsid: ""
    property bool   wifiConnected: false
    property bool   btPowered: false
    property int    btCount: 0

    spacing: 14
    anchors.verticalCenter: parent.verticalCenter

    Row {
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.wifiConnected ? "\ufa7c" : "\ue858"
            color: root.wifiConnected
                ? Colors.primary
                : Qt.hsla(
                    Qt.color(Colors.onSurface).hslHue,
                    Qt.color(Colors.onSurface).hslSaturation,
                    Qt.color(Colors.onSurface).hslLightness,
                    0.4)
            font.pixelSize: 15
            font.family: "JetBrainsMono Nerd Font"
        }

        Text {
            text: root.wifiConnected ? root.wifiSsid : "offline"
            color: Qt.hsla(
                Qt.color(Colors.onSurface).hslHue,
                Qt.color(Colors.onSurface).hslSaturation,
                Qt.color(Colors.onSurface).hslLightness,
                0.7)
            font.pixelSize: 11
            visible: true
        }
    }

    Rectangle {
        width: 1; height: 14
        color: Qt.hsla(
            Qt.color(Colors.outline).hslHue,
            Qt.color(Colors.outline).hslSaturation,
            Qt.color(Colors.outline).hslLightness,
            0.15)
        anchors.verticalCenter: parent.verticalCenter
    }

    Row {
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.btPowered ? "\uf294" : "\ue84d"
            color: root.btPowered
                ? Colors.primary
                : Qt.hsla(
                    Qt.color(Colors.onSurface).hslHue,
                    Qt.color(Colors.onSurface).hslSaturation,
                    Qt.color(Colors.onSurface).hslLightness,
                    0.4)
            font.pixelSize: 15
            font.family: "JetBrainsMono Nerd Font"
        }

        Text {
            visible: root.btCount > 0
            text: root.btCount + " dev"
            color: Qt.hsla(
                Qt.color(Colors.onSurface).hslHue,
                Qt.color(Colors.onSurface).hslSaturation,
                Qt.color(Colors.onSurface).hslLightness,
                0.7)
            font.pixelSize: 11
        }
    }
}
