pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: _
    
    readonly property real radius: (25)
    readonly property int edge: (10)

    readonly property int exclusiveZones: (edge + 20)
    readonly property int topExclusiveZone: (exclusiveZones + 0)
    readonly property int leftExclusiveZone: (exclusiveZones + 0)
    readonly property int rightExclusiveZone: (exclusiveZones + 0)
    readonly property int bottomExclusiveZone: (exclusiveZones + 0)

    readonly property int notificationDirection: (3)
    readonly property int notificationSpace: (10)
    readonly property int notificationWidth: (400)
    readonly property int notificationHeight: (80)
    readonly property font font: ({
        family: "Inter",
        pixelsize: 12,
    })
}
