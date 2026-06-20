import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "colors.js" as Colors

Window {
    id: root

    title: "quickshell-launcher"
    width: 460
    height: contentCol.height + 28
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool
    color: "transparent"

    visible: false

    property var launcherModel: null
    signal closeRequested()

    function openPopup() {
        x = (Screen.width - width) / 2
        y = 8
        show()
        requestActivate()
        focusTimer.start()
    }

    onActiveChanged: {
        if (!active && visible) closeRequested()
    }

    Timer {
        id: focusTimer
        interval: 100
        onTriggered: searchInput.forceActiveFocus()
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: Qt.hsla(
            Qt.color(Colors.surface).hslHue,
            Qt.color(Colors.surface).hslSaturation,
            Qt.color(Colors.surface).hslLightness,
            0.92)
        border.color: Qt.hsla(
            Qt.color(Colors.outline).hslHue,
            Qt.color(Colors.outline).hslSaturation,
            Qt.color(Colors.outline).hslLightness,
            0.12)
        border.width: 1

        Column {
            id: contentCol
            anchors {
                fill: parent
                margins: 14
            }
            spacing: 8

            Rectangle {
                width: parent.width
                height: 32
                radius: 8
                color: Qt.hsla(
                    Qt.color(Colors.surfaceVariant).hslHue,
                    Qt.color(Colors.surfaceVariant).hslSaturation,
                    Qt.color(Colors.surfaceVariant).hslLightness,
                    0.3)
                border.color: Qt.hsla(
                    Qt.color(Colors.outline).hslHue,
                    Qt.color(Colors.outline).hslSaturation,
                    Qt.color(Colors.outline).hslLightness,
                    0.12)
                border.width: 1

                Row {
                    anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10 }
                    spacing: 8

                    Text {
                        text: "\uf002"
                        color: Qt.hsla(Qt.color(Colors.onSurface).hslHue, Qt.color(Colors.onSurface).hslSaturation, Qt.color(Colors.onSurface).hslLightness, 0.5)
                        font.pixelSize: 13
                        font.family: "JetBrainsMono Nerd Font"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: searchInput
                        width: 360
                        color: Colors.onSurface
                        font.pixelSize: 13
                        selectionColor: Qt.hsla(Qt.color(Colors.primary).hslHue, Qt.color(Colors.primary).hslSaturation, Qt.color(Colors.primary).hslLightness, 0.4)
                        placeholderText: qsTr("Search apps\u2026")
                        placeholderTextColor: Qt.hsla(Qt.color(Colors.onSurface).hslHue, Qt.color(Colors.onSurface).hslSaturation, Qt.color(Colors.onSurface).hslLightness, 0.3)
                        background: null
                        focus: true

                        onTextChanged: {
                            if (root.launcherModel)
                                root.launcherModel.query = text
                        }

                        Keys.onEscapePressed: root.closeRequested()
                        Keys.onReturnPressed: {
                            if (appList.count > 0)
                                root.launcherModel.launch(root.launcherModel.filteredApps[0].exec)
                            root.closeRequested()
                        }
                    }
                }
            }

            Column {
                id: appList
                width: parent.width
                spacing: 2

                property int count: root.launcherModel ? root.launcherModel.filteredApps.length : 0

                Repeater {
                    model: root.launcherModel ? root.launcherModel.filteredApps : []

                    delegate: Rectangle {
                        required property var modelData

                        width: appList.width
                        height: 36
                        radius: 8
                        color: area.containsMouse
                            ? Qt.hsla(Qt.color(Colors.primary).hslHue, Qt.color(Colors.primary).hslSaturation, Qt.color(Colors.primary).hslLightness, 0.15)
                            : "transparent"

                        Behavior on color { ColorAnimation { duration: 100 } }

                        Row {
                            anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10 }
                            spacing: 10

                            Item {
                                width: 22; height: 22
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    id: appIcon
                                    anchors.fill: parent
                                    source: modelData.iconPath ? modelData.iconPath : ""
                                    fillMode: Image.PreserveAspectFit
                                    visible: status === Image.Ready
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.name ? modelData.name.charAt(0).toUpperCase() : "?"
                                    color: Colors.onSurface
                                    font.pixelSize: 11
                                    font.weight: Font.Bold
                                    visible: appIcon.status !== Image.Ready
                                }
                            }

                            Text {
                                text: modelData.name
                                color: Colors.onSurface
                                font.pixelSize: 13
                                anchors.verticalCenter: parent.verticalCenter
                                elide: Text.ElideRight
                                width: 330
                            }
                        }

                        MouseArea {
                            id: area
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.launcherModel.launch(modelData.exec)
                                root.closeRequested()
                            }
                        }
                    }
                }
            }
        }
    }
}
