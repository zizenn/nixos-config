import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: true

    required property var parentWindow

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
                    else if (mouse.button === Qt.RightButton) {
                        if (modelData.hasMenu)
                            modelData.display(parentWindow, mouse.x, mouse.y)
                    }
                }
            }
        }
    }
}
