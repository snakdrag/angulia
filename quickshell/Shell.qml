import QtQuick // for Item
import "components"
import "modules" as Modules
import "states" as States

Root {
    id: root
    modules: [..._edge.children, ..._overlay.children, ..._top.children, ..._bottom.children, ..._background.children, ]
    Layer {
        modules: _overlay
        layer: this.layers.Overlay
        focus: (
            States.Polkit.open ||
            States.Popup.open ||
            States.Ipc.open
        )
        Item {
            id: _overlay
            anchors.fill: parent
            layer.enabled: true
            Modules.WallpaperSwitcher {}
            Modules.Notifications {}
            Modules.Launcher {}
            Modules.Polkit {}
            Modules.Popup {}
        }
    }
    Layer {
        modules: _top
        layer: this.layers.Top
        Item {
            id: _top
            anchors.fill: parent
            layer.enabled: true
            Modules.Edge { id: _edge }
            Modules.Clock {}
            Modules.SystemTray {}
        }
    }
    Layer {
        modules: _bottom
        layer: this.layers.Bottom
        Item {
            id: _bottom
            anchors.fill: parent
            layer.enabled: true
        }
    }
    Layer {
        modules: _background
        layer: this.layers.Background
        Item {
            id: _background
            anchors.fill: parent
            layer.enabled: true
        }
    }
    Modules.LockScreen {}
}