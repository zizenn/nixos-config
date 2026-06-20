import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: true

    Text {
        text: "tray:" + (SystemTray && SystemTray.items ? SystemTray.items.count : "null")
        color: "red"; font.pixelSize: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: "hasItems:" + (SystemTray && SystemTray.items && SystemTray.items.count > 0 ? "yes" : "no")
        color: "yellow"; font.pixelSize: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Repeater {
        model: SystemTray.items

        delegate: Item {
            required property SystemTrayItem modelData
            width: 20; height: 20

            Image {
                anchors.fill: parent
                source: modelData ? modelData.icon : ""
                fillMode: Image.PreserveAspectFit
                smooth: true
                asynchronous: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: function(mouse) {
                    if (!modelData) return
                    if (mouse.button === Qt.LeftButton)
                        modelData.activate()
                    else
                        modelData.secondaryActivate()
                }
            }
        }
    }
}
