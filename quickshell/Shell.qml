import QtQuick // for Item
import "modules"
import "components"

Root {
    id: root
    childrens: [..._edge.children, ..._overlay.children, ..._top.children, ]
    modules: [..._top.children, ..._edge.children, ]
    Layer {
        modules: _overlay
        layer: this.layers.Overlay
        focus: (
            _launcher.show ||
            _wallpaperswitcher.show ||
            _polkit.show ||
            _popup.show
        )
        Item {
            id: _overlay
            anchors.fill: parent
            layer.enabled: true
            WallpaperSwitcher { id: _wallpaperswitcher }
            Launcher { id: _launcher }
            Polkit { id: _polkit }
            Popup { id: _popup }
            Notifications {}
        }
    }
    Layer {
        modules: _top
        layer: this.layers.Top
        Item {
            id: _top
            anchors.fill: parent
            layer.enabled: true
            Edge { id: _edge }
            Clock {}
            SystemTray {}
        }
    }
    LockScreen {}
}