import QtQuick
import Quickshell // for Region
import "modules" as Modules
import "angulia"

Root {
    id: root
    childrens: ([..._edge.children, ..._overlay.children, ..._top.children, ])
    modules: ([..._top.children, ])
    function ipcCloseAll()
    {
        _launcher.ipc.close()
        _wallpaperswitcher.ipc.close()
    }
    Layer {
        id: _Overlay
        modules: _overlay
        layer: layers.Overlay
        keyboardFocus: _launcher.show || _wallpaperswitcher.show
        Item {
            id: _overlay
            anchors.fill: parent
            Modules.Notifications {}
            Modules.WallpaperSwitcher { id: _wallpaperswitcher }
            Modules.Launcher { id: _launcher }
        }
    }
    Layer {
        id: _Top
        modules: _top
        layer: layers.Top
        Item {
            id: _top
            anchors.fill: parent
            Modules.Clock {}
            Modules.SystemTray {}
            Modules.Edge { id: _edge }
        }
    }
}