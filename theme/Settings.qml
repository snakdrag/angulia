pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property real radius: (12)
    readonly property int edge: (0)

    readonly property int float: (0)

    readonly property int exclusiveZones: (edge + 15)
    readonly property int topExclusiveZone: (exclusiveZones + 0)
    readonly property int leftExclusiveZone: (exclusiveZones + 0)
    readonly property int rightExclusiveZone: (exclusiveZones + 0)
    readonly property int bottomExclusiveZone: (exclusiveZones + 50 + float)

    readonly property int notificationDirection: (5)
    readonly property int notificationSpace: (10)
    readonly property int notificationWidth: (400)
    readonly property int notificationCardHeight: (80)
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
    readonly property int launcherSpace: (10)
    readonly property int launcherWidth: (400)
    readonly property int launcherHeight: (50)
    readonly property int launcherCardHeight: (50)
    readonly property bool launcherInputAtTop: (false)
    readonly property font launcherNameFont: ({
        family: "Inter",
        pixelSize: 12,
        bold: true,
    })
    readonly property font launcherCommentFont: ({
        family: "Inter",
        pixelSize: 12,
    })

}