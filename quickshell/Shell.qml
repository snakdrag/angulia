import QtQuick // for Item
import "modules"

Root {
    id: root
    childrens: ([..._edge.children, ..._overlay.children, ..._top.children, ])
    modules: ([..._top.children, ])
    gaps_out: 15
    edge: 5
    Layer {
        id: _Overlay
        modules: _overlay
        layer: this.layers.Overlay
        keyboardFocus: (
            _launcher.show ||
            _wallpaperswitcher.show ||
            _polkit.show
        )
        Item {
            id: _overlay
            anchors.fill: parent
            layer.enabled: true
            Notifications {}
            WallpaperSwitcher { id: _wallpaperswitcher }
            Launcher { id: _launcher }
            Polkit { id: _polkit }
        }
    }
    Layer {
        id: _Top
        modules: _top
        layer: this.layers.Top
        Item {
            id: _top
            anchors.fill: parent
            layer.enabled: true
            Edge { id: _edge }
            Clock {}
            SystemTray {}
            Popup { id: _popup }
        }
    }
    LockScreen {}
}