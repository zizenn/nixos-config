import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property string query: ""
    property var allApps: []
    property var filteredApps: []

    Component.onCompleted: reload()

    function reload() {
        desktopScanner.running = true
    }

    onQueryChanged: filter()

    function filter() {
        if (query.trim() === "") {
            var slice = []
            for (var i = 0; i < Math.min(allApps.length, 8); i++)
                slice.push(allApps[i])
            filteredApps = slice
            return
        }
        var q = query.toLowerCase()
        var results = []
        for (var i = 0; i < allApps.length; i++) {
            var app = allApps[i]
            if (app.name.toLowerCase().indexOf(q) !== -1 ||
                (app.keywords && app.keywords.toLowerCase().indexOf(q) !== -1)) {
                results.push(app)
                if (results.length >= 8) break
            }
        }
        filteredApps = results
    }

    function launch(exec) {
        var clean = exec.replace(/%[uUfFdDnNickvm]/g, "").trim()
        launcher.command = ["sh", "-c", clean + " &"]
        launcher.running = true
    }

    Process {
        id: desktopScanner
        command: ["bash", "-c",
            "find /run/current-system/sw/share/applications ~/.local/share/applications " +
            "-name '*.desktop' 2>/dev/null | sort -u | head -300"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                fileReader.paths.push(data.trim())
            }
        }
        onExited: {
            fileReader.index = 0
            fileReader.results = []
            fileReader.readNext()
        }
    }

    QtObject {
        id: fileReader
        property var paths: []
        property int index: 0
        property var results: []

        function readNext() {
            if (index >= paths.length) {
                root.allApps = results.sort(function(a, b) {
                    return a.name.localeCompare(b.name)
                })
                root.filter()
                return
            }
            singleReader.command = ["cat", paths[index]]
            singleReader.running = true
        }
    }

    Process {
        id: singleReader
        running: false
        stdout: StdioCollector {
            id: collector
            onStreamFinished: singleReader.parse(collector.data)
        }
        onExited: {
            fileReader.index++
            fileReader.readNext()
        }

        function parse(text) {
            var lines = text.split("\n")
            var inEntry = false
            var name = "", exec = "", icon = "", noDisplay = false, keywords = ""
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i]
                if (line.charAt(0) === "[") {
                    inEntry = line === "[Desktop Entry]"
                    continue
                }
                if (!inEntry) continue
                if (line.indexOf("Name=") === 0 && name === "") name = line.substring(5)
                else if (line.indexOf("Exec=") === 0) exec = line.substring(5)
                else if (line.indexOf("Icon=") === 0) icon = line.substring(5)
                else if (line.indexOf("NoDisplay=") === 0) noDisplay = line.substring(10).toLowerCase() === "true"
                else if (line.indexOf("Keywords=") === 0) keywords = line.substring(9)
            }
            if (name && exec && !noDisplay) {
                fileReader.results.push({ name: name, exec: exec, icon: icon, keywords: keywords })
            }
        }
    }

    Process {
        id: launcher
        running: false
    }
}
