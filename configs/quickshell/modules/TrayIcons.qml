import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: true

    property var trayItems: []

    function refresh() {
        var arr = []
        for (var i = 0; i < SystemTray.items.length; i++)
            arr.push(SystemTray.items[i])
        trayItems = arr
        console.log("TRAY: items.length=" + SystemTray.items.length + " copied=" + arr.length)
        if (arr.length > 0) {
            console.log("TRAY: first item icon=" + arr[0].icon + " id=" + arr[0].id)
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: refresh()
    }

    Repeater {
        model: trayItems

        delegate: Item {
            required property var modelData
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
