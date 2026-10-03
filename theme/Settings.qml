pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property real radius: (12)
    readonly property int edge: (5)

    readonly property int float: (10)
    readonly property int space: (10)

    readonly property int exclusiveZones: (edge + 15)
    readonly property int topExclusiveZone: (exclusiveZones + 0)
    readonly property int leftExclusiveZone: (exclusiveZones + 0)
    readonly property int rightExclusiveZone: (exclusiveZones + 0)
    readonly property int bottomExclusiveZone: (exclusiveZones + float + 50)

    readonly property int notificationDirection: (2)
    readonly property int notificationCardWidth: (360)
    readonly property int notificationCardHeight: (60)
    readonly property bool notificationIsVertical: (true)
    readonly property font notificationSummaryFont: ({ family: "Inter", pixelSize: 15, bold: true, })
    readonly property font notificationBodyFont: ({ family: "Inter", pixelSize: 15, bold: false, })

    readonly property int launcherDirection: (1)
    readonly property int launcherCardWidth: (60)
    readonly property int launcherCardHeight: (60)
    readonly property int launcherInputHeight: (30)
    readonly property bool launcherInputAtTop: (true)
    readonly property bool launcherIsVertical: (false)
    readonly property font launcherNameFont: ({ family: "Inter", pixelSize: 12, bold: true, })
    readonly property font launcherCommentFont: ({ family: "Inter", pixelSize: 12, })

    readonly property int clockDirection: (5)
    readonly property int clcokWidth: (300)
    readonly property int clcokHeight: (50)
    readonly property font clockFont: ({ family: "Inter", pixelSize: 15, bold: false, })

    readonly property int systemtrayDirection: (4)
    readonly property int systemtrayIconSize: (30)
    readonly property bool systemtrayIsVertical: (false)
}