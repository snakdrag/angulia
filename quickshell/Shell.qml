import Quickshell // for ShellRoot and Region
import "modules" as Modules
import "layers" as Layers
import "../settings" as S

ShellRoot {
    Layers.ExclusiveZones {
        topExclusiveZone: S.Settings.topExclusiveZone
        leftExclusiveZone: S.Settings.leftExclusiveZone
        rightExclusiveZone: S.Settings.rightExclusiveZone
        bottomExclusiveZone: S.Settings.bottomExclusiveZone
    }
    Layers.Layer {
        id: _overlay
        layer: layers.Overlay
        mask: Region { regions: [_notifications.region,] }
        keyboardFocus: _launcher.show
        Modules.Notifications { id: _notifications; direction: S.Settings.notificationDirection % 8 }
        Modules.Launcher { id: _launcher; direction: S.Settings.launcherDirection }
    }
    Layers.Layer {
        id: _top
        layer: layers.Top
        mask: Region { regions: [_systemtray.region,] }
        Modules.Edge {}
        Modules.Clock { direction: S.Settings.clockDirection }
        Modules.SystemTray { id: _systemtray; direction: S.Settings.systemtrayDirection; cardColor: "transparent" }
    }
}