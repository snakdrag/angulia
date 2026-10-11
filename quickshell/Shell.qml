import QtQuick
import Quickshell // for Region
import "modules" as Modules
import "angulia"

Root {
    id: root
    childrens: ([..._edge.children, ..._overlay.children, ..._top.children, ])
    modules: ([..._top.children, ])
    Layer {
        id: _Overlay
        layer: layers.Overlay
        modules: _overlay
        keyboardFocus: _launcher.show
        Item {
            id: _overlay
            anchors.fill: parent
            Modules.Notifications {}
            Modules.Launcher { id: _launcher }
        }
    }
    Layer {
        id: _Top
        layer: layers.Top
        modules: _top
        Item {
            id: _top
            anchors.fill: parent
            Modules.Clock {}
            Modules.SystemTray {}
            Modules.Edge { id: _edge }
        }
    }
}