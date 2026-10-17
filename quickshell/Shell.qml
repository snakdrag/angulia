import QtQuick // for Item
import Quickshell // for Region
import "angulia" // for Root
import "modules" as Modules

Root {
    id: root
    childrens: ([..._edge.children, ..._overlay.children, ..._top.children, ])
    modules: ([..._top.children, ])
    Layer {
        id: _Overlay
        modules: _overlay
        layer: this.layers.Overlay
        keyboardFocus: _launcher.show || _wallpaperswitcher.show
        Item {
            id: _overlay
            anchors.fill: parent
            layer.enabled: true
            Modules.Notifications {}
            Modules.WallpaperSwitcher { id: _wallpaperswitcher }
            Modules.Launcher { id: _launcher }
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
            Modules.Clock {}
            Modules.SystemTray {}
            Modules.Edge { id: _edge }
        }
    }
    LockScreen {}
}