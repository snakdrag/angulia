import QtQuick
import Quickshell
import "../../settings"
import "../../theme"

Rectangle {
    id: _

    color: Colors.surface
    property color cardColor: (Colors.surface_container)
    property color backgroundColor: (Colors.surface)
    property color textColor: (Colors.on_surface)

    property int notificationCardWidth: (Settings.notificationCardWidth)
    property int notificationCardHeight: (Settings.notificationCardHeight)
    property int notificationImageSize: (Settings.notificationImageSize)
    property bool notificationIsVertical: (Settings.notificationIsVertical)
    property font notificationSummaryFont: (Settings.notificationSummaryFont)
    property font notificationBodyFont: (Settings.notificationBodyFont)

    property int launcherCardWidth: (Settings.launcherCardWidth)
    property int launcherCardHeight: (Settings.launcherCardHeight)
    property int launcherInputHeight: (Settings.launcherInputHeight)
    property int launcherImageSize: (Settings.launcherImageSize)
    property bool launcherInputAtTop: (Settings.launcherInputAtTop)
    property bool launcherIsVertical: (Settings.launcherIsVertical)
    property font launcherNameFont: (Settings.launcherNameFont)
    property font launcherCommentFont: (Settings.launcherCommentFont)

    property int clcokWidth: (Settings.clcokWidth)
    property int clcokHeight: (Settings.clcokHeight)
    property font clockFont: (Settings.clockFont)

    property int systemtrayIconSize: (Settings.systemtrayIconSize)
    property bool systemtrayIsVertical: (Settings.systemtrayIsVertical)

    radius: Settings.radius
    property int edge: (Settings.edge)
    property int float: (Settings.float)
    property int space: (Settings.space)

    property int direction: (1)

    readonly property bool _IsTop: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 2 )
    readonly property bool _IsLeft: ( direction % 9 === 0 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsRight: ( direction % 9 === 2 || direction % 9 === 3 || direction % 9 === 4 )
    readonly property bool _IsBottom: ( direction % 9 === 4 || direction % 9 === 5 || direction % 9 === 6 )

    readonly property bool _IsTopBottom: ( direction % 9 === 1 || direction % 9 === 5 || direction % 9 === 8)
    readonly property bool _IsLeftRight: ( direction % 9 === 3 || direction % 9 === 7 || direction % 9 === 8)

    readonly property bool _IsTopLeft: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 7 )
    readonly property bool _IsTopRight: ( direction % 9 === 1 || direction % 9 === 2 || direction % 9 === 3 )
    readonly property bool _IsBottomLeft: ( direction % 9 === 5 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsBottomRight: ( direction % 9 === 3 || direction % 9 === 4 || direction % 9 === 5 )

    anchors.margins: edge + float
    x: (
        _IsLeft ? anchors.leftMargin:
        _IsRight ? parent.width - implicitWidth - anchors.rightMargin: (parent.width - implicitWidth) / 2
    )
    y: (
        _IsTop ? anchors.topMargin:
        _IsBottom ? parent.height - implicitHeight - anchors.bottomMargin: (parent.height - implicitHeight) / 2
    )
    Behavior on x {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    property bool isTop: (_IsTop)
    property bool isLeft: (_IsLeft)
    property bool isRight: (_IsRight)
    property bool isBottom: (_IsBottom)

    property bool isTopLeft: (isLeft)
    property bool isTopRight: (isRight)
    property bool isLeftTop: (isTop)
    property bool isLeftBottom: (isBottom)
    property bool isRightTop: (isTop)
    property bool isRightBottom: (isBottom)
    property bool isBottomLeft: (isLeft)
    property bool isBottomRight: (isRight)

    topLeftRadius: (isTopLeft || isLeftTop) && !float ? 0: radius
    topRightRadius: (isTopRight || isRightTop) && !float ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom) && !float ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom) && !float ? 0: radius

    property Region region: (_region)
    Region { id: _region; item: _ }

    property bool show: (true)

    width: implicitWidth
    height: implicitHeight
    Behavior on width {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopLeft && !_.isTop && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopRight && !_.isTop && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftTop && !_.isLeft && !_.float ? 1: 0
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftBottom && !_.isLeft && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightTop && !_.isRight && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightBottom && !_.isRight && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomLeft && !_.isBottom && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomRight && !_.isBottom && !_.float ? 1: 0
        rotation: 90
    }
}