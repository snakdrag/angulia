pragma Singleton
import Quickshell // for Singleton and Quickshell.env
import Quickshell.Io // for FileView and JSON.parse

Singleton {
    readonly property var data: (JSON.parse(_angulia.text()))
    FileView {
        id: _angulia
        path: Quickshell.env("HOME") + "/.config/angulia/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }
}