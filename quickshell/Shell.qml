import QtQuick
import Quickshell // for ShellRoot and Region
import "modules" as Modules
import "layers"
import "angulia"
import "../settings" as S

ShellRoot {
    ExclusiveZones {
        gaps_out: S.Settings.gaps_out
        topExclusiveZone: S.Settings.topExclusiveZone
        leftExclusiveZone: S.Settings.leftExclusiveZone
        rightExclusiveZone: S.Settings.rightExclusiveZone
        bottomExclusiveZone: S.Settings.bottomExclusiveZone
    }
    Layer {
        id: _overlay
        layer: layers.Overlay
        mask: Region { regions: [Region { item: _notifications }, ] }
        keyboardFocus: _launcher.show
        Modules.Notifications { id: _notifications; direction: S.Settings.notificationDirection }
        Modules.Launcher { id: _launcher; direction: S.Settings.launcherDirection }
    }
    Layer {
        id: _top
        layer: layers.Top
        mask: Region { regions: [Region { item: _systemtray }, ] }
        Modules.SystemTray { id: _systemtray; direction: S.Settings.systemtrayDirection; cardColor: "transparent" }
    }
    Top {}

}