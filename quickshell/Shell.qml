import QtQuick // for Item
import "old" as Modules
import "modules"

Root {
    id: root
    childrens: ([..._edge.children, ..._overlay.children, ..._top.children, ])
    modules: ([..._top.children, ])
    bar: _popup.bar
    gaps_out: _popup.gaps_out
    float: _popup.float
    edge: _popup.edge
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
            // Modules.Notifications {}
            Modules.WallpaperSwitcher { id: _wallpaperswitcher }
            Modules.Launcher { id: _launcher }
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
            Modules.Popup { id: _popup }
            Clock {}
            Modules.SystemTray {}
        }
    }
    Modules.LockScreen {}
}