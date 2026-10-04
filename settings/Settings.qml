pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property var data: (Angulia.data)

    readonly property real radius: (data.radius || 0)
    readonly property int edge: (data.edge || 0)

    readonly property int float: (data.float || 0)
    readonly property int space: (data.space || 0)

    readonly property int exclusiveZones: (edge + (data.gaps_out || 0))
    readonly property int topExclusiveZone: (exclusiveZones + (0))
    readonly property int leftExclusiveZone: (exclusiveZones + (0))
    readonly property int rightExclusiveZone: (exclusiveZones + (0))
    readonly property int bottomExclusiveZone: (exclusiveZones + (0))

    readonly property int notificationDirection: (data.notification.direction || 0)
    readonly property int notificationCardWidth: (160)
    readonly property int notificationCardHeight: (360)
    readonly property int notificationImageSize: (40)
    readonly property bool notificationIsVertical: (false)
    readonly property font notificationSummaryFont: ({ family: "Inter", pixelSize: 15, bold: true, })
    readonly property font notificationBodyFont: ({ family: "Inter", pixelSize: 15, bold: false, })

    readonly property int launcherDirection: (1)
    readonly property int launcherCardWidth: (120)
    readonly property int launcherCardHeight: (85)
    readonly property int launcherImageSize: (40)
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