pragma Singleton
import Quickshell // for Singleton and Quickshell.env
import Quickshell.Io // for FileView and JSON.parse
import "colors" // for Colors

Singleton {

    readonly property var data: (JSON.parse(_angulia.text()))
    FileView {
        id: _angulia
        path: Quickshell.env("HOME") + "/.config/angulia/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    readonly property var colors: (Colors)
    readonly property var fonts: (data.fonts)

    readonly property real radius: (data.radius)
    readonly property int edge: (data.edge)

    readonly property int float: (data.float)
    readonly property int space: (data.space)

    readonly property var bar: (data.bar)

    // exclusiveZones
    readonly property int gaps_out: (data.gaps_out)

    readonly property int exclusiveZones: (edge)
    readonly property int topExclusiveZone: (exclusiveZones + (_top ? float + bar.height: 0))
    readonly property int leftExclusiveZone: (exclusiveZones + (_left ? float + bar.width: 0))
    readonly property int rightExclusiveZone: (exclusiveZones + (_right ? float + bar.width: 0))
    readonly property int bottomExclusiveZone: (exclusiveZones + (_bottom ? float + bar.height: 0))

    readonly property bool _top: (
        (_clock.isTop && !clockIsVertical) ||
        (_systemtray.isTop && !systemtrayIsVertical)
    )
    readonly property bool _left: (
        (_clock.isLeft && clockIsVertical) ||
        (_systemtray.isLeft && systemtrayIsVertical)
    )
    readonly property bool _right: (
        (_clock.isRight && clockIsVertical) ||
        (_systemtray.isRight && systemtrayIsVertical)
    )
    readonly property bool _bottom: (
        (_clock.isBottom && !clockIsVertical) ||
        (_systemtray.isBottom && !systemtrayIsVertical)
    )

    // notification
    readonly property var notification: (data.notification)

    readonly property int notificationDirection: (notification.direction)
    readonly property bool notificationIsVertical: (notification.isVertical)
    readonly property int notificationCardWidth: (notification.card.width)
    readonly property int notificationCardHeight: (notification.card.height)
    readonly property int notificationImageSize: (notification.card.image)
    readonly property var notificationSummaryFont: (fonts.summary)
    readonly property var notificationBodyFont: (fonts.body)

    // launcher
    readonly property var launcher: (data.launcher)

    readonly property int launcherDirection: (launcher.direction)
    readonly property bool launcherIsVertical: (launcher.isVertical)
    readonly property int launcherCardWidth: (launcher.card.width)
    readonly property int launcherCardHeight: (launcher.card.height)
    readonly property int launcherImageSize: (launcher.card.image)
    readonly property var launcherNameFont: (fonts.name)
    readonly property var launcherCommentFont: (fonts.comment)
    readonly property int launcherInputHeight: (bar.height - space * 2)
    readonly property bool launcherInputAtTop: (launcher.inputAtTop)

    // clock
    readonly property var clock: (data.clock)
    Direction { id: _clock; direction: clock.direction}

    readonly property int clockDirection: (clock.direction)
    readonly property bool clockIsVertical: (clock.isVertical)
    readonly property int clcokWidth: (clockIsVertical ? bar.width: clock.width)
    readonly property int clcokHeight: (clockIsVertical ? clock.height: bar.height)
    readonly property var clockFont: (fonts.body)

    // systemtray
    readonly property var systemtray: (data.systemtray)
    Direction { id: _systemtray; direction: systemtray.direction}

    readonly property int systemtrayDirection: (systemtray.direction)
    readonly property bool systemtrayIsVertical: (systemtray.isVertical)
    readonly property int systemtrayCardWidth: ((systemtrayIsVertical ? bar.width: bar.height) - space * 2)
    readonly property int systemtrayCardHeight: ((systemtrayIsVertical ? bar.width: bar.height) - space * 2)
    readonly property int systemtrayIconSize: (systemtray.card.image)
}