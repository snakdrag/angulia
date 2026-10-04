pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property real radius: (Angulia.data.radius)
    readonly property int edge: (Angulia.data.edge)

    readonly property int float: (Angulia.data.float)
    readonly property int space: (Angulia.data.space)

    readonly property int exclusiveZones: (edge + (Angulia.data.gaps_out))
    readonly property int topExclusiveZone: (exclusiveZones + (0))
    readonly property int leftExclusiveZone: (exclusiveZones + (0))
    readonly property int rightExclusiveZone: (exclusiveZones + (0))
    readonly property int bottomExclusiveZone: (exclusiveZones + (50))

    readonly property int notificationDirection: (Angulia.data.notification.direction)
    readonly property bool notificationIsVertical: (Angulia.data.notification.isVertical)
    readonly property int notificationCardWidth: (Angulia.data.notification.card.width)
    readonly property int notificationCardHeight: (Angulia.data.notification.card.height)
    readonly property int notificationImageSize: (Angulia.data.notification.card.image)
    readonly property font notificationSummaryFont: (Angulia.data.font.summary)
    readonly property font notificationBodyFont: (Angulia.data.font.body)

    readonly property int launcherDirection: (Angulia.data.launcher.direction)
    readonly property bool launcherIsVertical: (Angulia.data.launcher.isVertical)
    readonly property int launcherCardWidth: (Angulia.data.launcher.card.width)
    readonly property int launcherCardHeight: (Angulia.data.launcher.card.height)
    readonly property int launcherImageSize: (Angulia.data.launcher.card.image)
    readonly property font launcherNameFont: (Angulia.data.font.name)
    readonly property font launcherCommentFont: (Angulia.data.font.comment)
    readonly property int launcherInputHeight: (Math.min(Angulia.data.bar.width, Angulia.data.bar.height) - space * 2)
    readonly property bool launcherInputAtTop: (Angulia.data.launcher.inputAtTop)

    readonly property int clockDirection: (Angulia.data.clock.direction)
    readonly property bool clockIsVertical: (Angulia.data.clock.isVertical)
    readonly property int clcokWidth: (clockIsVertical ? Angulia.data.bar.width: Angulia.data.clock.width)
    readonly property int clcokHeight: (clockIsVertical ? Angulia.data.clock.height: Angulia.data.bar.height)
    readonly property font clockFont: (Angulia.data.font.body)

    readonly property int systemtrayDirection: (Angulia.data.systemtray.direction)
    readonly property bool systemtrayIsVertical: (Angulia.data.systemtray.isVertical)
    readonly property int systemtrayIconSize: ((systemtrayIsVertical ? Angulia.data.bar.width: Angulia.data.bar.height) - space * 2)
}