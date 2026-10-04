pragma Singleton
import QtQuick
import Quickshell

Singleton {

    readonly property real radius: (Angulia.data.radius)
    readonly property int edge: (Angulia.data.edge)

    readonly property int float: (Angulia.data.float)
    readonly property int space: (Angulia.data.space)

    readonly property int barWidth: (Angulia.data.bar.width)
    readonly property int barHeight: (Angulia.data.bar.height)

    readonly property int exclusiveZones: (edge + (Angulia.data.gaps_out))
    readonly property int topExclusiveZone: (exclusiveZones + (_top ? barHeight + float: 0))
    readonly property int leftExclusiveZone: (exclusiveZones + (_left ? barWidth + float: 0))
    readonly property int rightExclusiveZone: (exclusiveZones + (_right ? barWidth + float: 0))
    readonly property int bottomExclusiveZone: (exclusiveZones + (_bottom ? barHeight + float: 0))

    readonly property bool _top: (
        (_clock._IsTop && !clockIsVertical) ||
        (_systemtray._IsTop && !systemtrayIsVertical)
    )
    readonly property bool _left: (
        (_clock._IsLeft && clockIsVertical) ||
        (_systemtray._IsLeft && systemtrayIsVertical)
    )
    readonly property bool _right: (
        (_clock._IsRight && clockIsVertical) ||
        (_systemtray._IsRight && systemtrayIsVertical)
    )
    readonly property bool _bottom: (
        (_clock._IsBottom && !clockIsVertical) ||
        (_systemtray._IsBottom && !systemtrayIsVertical)
    )

    readonly property int notificationDirection: (Angulia.data.notification.direction % 8)
    readonly property bool notificationIsVertical: (Angulia.data.notification.isVertical)
    readonly property int notificationCardWidth: (Angulia.data.notification.card.width)
    readonly property int notificationCardHeight: (Angulia.data.notification.card.height)
    readonly property int notificationImageSize: (Angulia.data.notification.card.image)
    readonly property font notificationSummaryFont: (Angulia.data.font.summary)
    readonly property font notificationBodyFont: (Angulia.data.font.body)

    readonly property int launcherDirection: (Angulia.data.launcher.direction % 9)
    readonly property bool launcherIsVertical: (Angulia.data.launcher.isVertical)
    readonly property int launcherCardWidth: (Angulia.data.launcher.card.width)
    readonly property int launcherCardHeight: (Angulia.data.launcher.card.height)
    readonly property int launcherImageSize: (Angulia.data.launcher.card.image)
    readonly property font launcherNameFont: (Angulia.data.font.name)
    readonly property font launcherCommentFont: (Angulia.data.font.comment)
    readonly property int launcherInputHeight: (barHeight - space * 2)
    readonly property bool launcherInputAtTop: (Angulia.data.launcher.inputAtTop)

    readonly property int clockDirection: (Angulia.data.clock.direction % 8)
    readonly property bool clockIsVertical: (Angulia.data.clock.isVertical)
    readonly property int clcokWidth: (clockIsVertical ? barWidth: Angulia.data.clock.width)
    readonly property int clcokHeight: (clockIsVertical ? Angulia.data.clock.height: barHeight)
    readonly property font clockFont: (Angulia.data.font.body)
    Direction { id: _clock; direction: clockDirection}

    readonly property int systemtrayDirection: (Angulia.data.systemtray.direction % 8)
    readonly property bool systemtrayIsVertical: (Angulia.data.systemtray.isVertical)
    readonly property int systemtrayCardWidth: ((systemtrayIsVertical ? barWidth: barHeight) - space * 2)
    readonly property int systemtrayCardHeight: ((systemtrayIsVertical ? barWidth: barHeight) - space * 2)
    readonly property int systemtrayIconSize: (Angulia.data.systemtray.card.image)
    Direction { id: _systemtray; direction: systemtrayDirection}

}