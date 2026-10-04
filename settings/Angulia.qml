pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    FileView {
        id: colorsFile
        path: Quickshell.env("HOME") + "/.config/angulia/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    readonly property var data: (JSON.parse(colorsFile.text()))
}
