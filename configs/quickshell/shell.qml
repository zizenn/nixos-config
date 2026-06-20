import Quickshell
import QtQuick
import "./services" as Services

ShellRoot {
    Services.ColorService { id: colors }

    DynamicIslandBar {
        colors: colors
    }
}
