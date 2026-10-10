import QtQuick
import Quickshell // for ShellRoot and Region
import "modules" as Modules
import "layers"
import "angulia"
import "../settings" as S

Root {
    childrens: ([..._top.children, ..._edge.children, ])
    modules: ([_clock, ])
    Layer {
        layer: layers.Overlay
        mask: Region { regions: [Region { item: _notifications }, ] }
        keyboardFocus: _launcher.show
        Item {
            id: _overlay
            anchors.fill: parent
            Modules.Notifications { id: _notifications; direction: S.Settings.notificationDirection }
            Modules.Launcher { id: _launcher; direction: S.Settings.launcherDirection }
        }
    }
    Layer {
        layer: layers.Top
        mask: Region { regions: [Region { item: _clock }, ] }
        Item {
            id: _top
            anchors.fill: parent
            Modules.Clock { id: _clock }
            Modules.Edge { id: _edge }
        }
    }
}