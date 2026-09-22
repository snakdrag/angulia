pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: _
    
    readonly property real radius: (25)
    readonly property int edge: (10)

    readonly property int exclusiveZones: (edge + 15)
    readonly property int topExclusiveZone: (exclusiveZones + 0)
    readonly property int leftExclusiveZone: (exclusiveZones + 0)
    readonly property int rightExclusiveZone: (exclusiveZones + 0)
    readonly property int bottomExclusiveZone: (exclusiveZones + 50)

    readonly property int notificationDirection: (5)
    readonly property int notificationSpace: (10)
    readonly property int notificationWidth: (400)
    readonly property int notificationHeight: (80)
    readonly property font notificationSummaryFont: ({
        family: "Inter",
        pixelSize: 15,
        bold: true,
    })
    readonly property font notificationBodyFont: ({
        family: "Inter",
        pixelSize: 15,
        bold: false,
    })

    readonly property int clockDirection: (5)
    readonly property int clockWidth: (200)
    readonly property int clockHeight: (50)
    readonly property font clockFont: ({
        family: "Inter",
        pixelSize: 15,
        bold: false,
    })


    readonly property int launcherDirection: (1)
    readonly property int launcherAppWidth: (400)
    readonly property int launcherAppHeight: (60)
    readonly property int launcherInputHeight: (30)
    readonly property font launcherAppFont: ({
        family: "Inter",
        bold: true,
    })
    readonly property font launcherDescribeFont: ({
        family: "Inter",
    })
    readonly property int launcherSpace: (10)
}
