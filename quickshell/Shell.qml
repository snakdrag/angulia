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
        focus: States.WallpaperSwitcher.open || States.Launcher.open || States.Polkit.open
        LayerModule {
            id: _overlay

        }
    }
    Layer {
        modules: _top
        layer: this.layers.Top
        LayerModule {
            id: _top

            Modules.Close {
                show: (
                    States.WallpaperSwitcher.open ||
                    States.Launcher.open ||
                    States.Polkit.open ||
                    States.Popup.open
                )
            }
            Modules.WallpaperSwitcher {}
            Modules.Notifications {}
            Modules.Launcher {}
            Modules.Polkit {}
            Modules.Popup {}
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