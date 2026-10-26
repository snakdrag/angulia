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
            States.WallpaperSwitcher.open ||
            States.Launcher.open ||
            States.Polkit.open ||
            States.SystemTrayPopup.open
        )
        Item {
            id: _overlay
            anchors.fill: parent
            layer.enabled: true
            Modules.WallpaperSwitcher {}
            Modules.Launcher {}
            Modules.Polkit {}
            Modules.SystemTrayPopup {}
            Modules.Notifications {}
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
            Modules.ActiveWindow {}
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