import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: SystemTray.items.count > 0

    Text {
        text: "tray:" + SystemTray.items.count
        color: "red"; font.pixelSize: 10
        anchors.verticalCenter: parent.verticalCenter
        visible: true
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
