import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property string query: ""
    property var allApps: []
    property var filteredApps: []

    property Process scannerProc: Process {
        command: ["bash", "-c",
            "find /run/current-system/sw/share/applications ~/.local/share/applications ~/.nix-profile/share/applications /etc/profiles/per-user/$USER/share/applications -name '*.desktop' 2>/dev/null | sort -u | head -500 | while read f; do name=\"\"; exec=\"\"; icon=\"\"; nodisplay=\"\"; while IFS= read -r line; do case \"$line\" in \"Name=\"*) [ -z \"$name\" ] && name=\"${line#Name=}\" ;; \"Exec=\"*) exec=\"${line#Exec=}\" ;; \"Icon=\"*) icon=\"${line#Icon=}\" ;; \"NoDisplay=true\") nodisplay=1 ;; esac; done < \"$f\"; [ -n \"$name\" ] && [ -n \"$exec\" ] && [ -z \"$nodisplay\" ] || continue; iconpath=\"\"; [ -n \"$icon\" ] && [ -f \"$icon\" ] && iconpath=\"$icon\"; [ -z \"$iconpath\" ] && [ -f \"/run/current-system/sw/share/icons/hicolor/48x48/apps/$icon.png\" ] && iconpath=\"/run/current-system/sw/share/icons/hicolor/48x48/apps/$icon.png\"; [ -z \"$iconpath\" ] && [ -f \"/run/current-system/sw/share/icons/hicolor/scalable/apps/$icon.svg\" ] && iconpath=\"/run/current-system/sw/share/icons/hicolor/scalable/apps/$icon.svg\"; [ -z \"$iconpath\" ] && [ -f \"$HOME/.local/share/icons/hicolor/48x48/apps/$icon.png\" ] && iconpath=\"$HOME/.local/share/icons/hicolor/48x48/apps/$icon.png\"; [ -z \"$iconpath\" ] && [ -f \"$HOME/.local/share/icons/hicolor/scalable/apps/$icon.svg\" ] && iconpath=\"$HOME/.local/share/icons/hicolor/scalable/apps/$icon.svg\"; [ -z \"$iconpath\" ] && [ -f \"$HOME/.nix-profile/share/icons/hicolor/48x48/apps/$icon.png\" ] && iconpath=\"$HOME/.nix-profile/share/icons/hicolor/48x48/apps/$icon.png\"; [ -z \"$iconpath\" ] && [ -f \"$HOME/.nix-profile/share/icons/hicolor/scalable/apps/$icon.svg\" ] && iconpath=\"$HOME/.nix-profile/share/icons/hicolor/scalable/apps/$icon.svg\"; echo \"APP|$name|$exec|$iconpath\"; done"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                var parts = data.split("|")
                if (parts.length >= 4 && parts[0] === "APP") {
                    root.allAppsRaw.push({
                        name: parts[1],
                        exec: parts[2],
                        iconPath: parts[3] || ""
                    })
                }
            }
        }
        onExited: {
            root.allApps = root.allAppsRaw.sort(function(a, b) {
                return a.name.localeCompare(b.name)
            })
            root.allAppsRaw = []
            root.filter()
        }
    }

    property var allAppsRaw: []

    property Process launcherProcess: Process {
        running: false
    }

    Component.onCompleted: reload()

    function reload() {
        allApps = []
        filteredApps = []
        allAppsRaw = []
        scannerProc.running = true
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
            if (app.name.toLowerCase().indexOf(q) !== -1) {
                results.push(app)
                if (results.length >= 8) break
            }
        }
        filteredApps = results
    }

    function launch(exec) {
        var clean = exec.replace(/%[uUfFdDnNickvm]/g, "").trim()
        launcherProcess.command = ["sh", "-c", clean + " &"]
        launcherProcess.running = true
    }
}
