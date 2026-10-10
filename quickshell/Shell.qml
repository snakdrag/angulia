import QtQuick
import Quickshell // for Region
import "modules" as Modules
import "angulia"
import "../settings" as S

Root {
    childrens: ([..._top.children, ..._edge.children, ])
    modules: ([..._top.children, ..._overlay.children, ])
    Layer {
        id: _Overlay
        layer: layers.Overlay
        modules: [..._overlay.children, ]
        keyboardFocus: _launcher.show
        Item {
            id: _overlay
            anchors.fill: parent
            Modules.Notifications { id: _notifications; direction: S.Settings.notificationDirection }
            Modules.Launcher { id: _launcher; direction: S.Settings.launcherDirection }
        }
    }
    Layer {
        id: _Top
        layer: layers.Top
        modules: [..._top.children, ]
        Item {
            id: _top
            anchors.fill: parent
            Modules.Clock {}
            Modules.SystemTray {}
            Modules.Edge { id: _edge }
        }
    }
}