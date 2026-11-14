import QtQuick // for Item
import "components"
import "modules" as Modules
import "states" as States

Root {
    id: root

    modules: [..._edge.children, ..._overlay.children, ..._top.children, ..._bottom.children, ..._background.children, ]

    component LayerModule: Item { anchors.fill: parent }

    Modules.LockScreen {}
    Layer {
        modules: _overlay
        layer: this.layers.Overlay
        focus: States.Ipc.open || States.Polkit.open
        LayerModule {
            id: _overlay

            Modules.Close { show: States.Popup.open || States.Ipc.open || States.Polkit.open }
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
        LayerModule {
            id: _top

            Modules.Edge { id: _edge }
            Modules.Clock {}
            Modules.SystemTray {}
        }
    }
    Layer {
        modules: _bottom
        layer: this.layers.Bottom
        LayerModule {
            id: _bottom
        }
    }
    Layer {
        modules: _background
        layer: this.layers.Background
        LayerModule {
            id: _background
            Modules.Background {}
        }
    }
}