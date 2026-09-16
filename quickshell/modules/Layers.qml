import Quickshell 
import "layers" as Layers
import "top" as Top
import "overlay" as Overlay

ShellRoot {
    Layers.ExclusiveZones {}
    Layers.Background {
        mask: Region {}
    }
    Layers.Bottom {
        mask: Region {}
    }
    Layers.Top {
        mask: Region {}
        Top.Edge {}
        Top.Notifications {}
    }
    Layers.Overlay {
        mask: Region { regions: [_notifications.region, ] }
        Overlay.Notifications { id: _notifications }
    }
}