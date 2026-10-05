import QtQuick
import Quickshell
import "../../settings" as S
import "../../theme" as T

Rectangle {
    id: _

    property int direction: (1)

    readonly property bool _IsTop: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 2 )
    readonly property bool _IsLeft: ( direction % 9 === 0 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsRight: ( direction % 9 === 2 || direction % 9 === 3 || direction % 9 === 4 )
    readonly property bool _IsBottom: ( direction % 9 === 4 || direction % 9 === 5 || direction % 9 === 6 )

    readonly property bool _IsTopBottom: ( direction % 9 === 1 || direction % 9 === 5 || direction % 9 === 8)
    readonly property bool _IsLeftRight: ( direction % 9 === 3 || direction % 9 === 7 || direction % 9 === 8)

    property bool isTopLeft: (_IsLeft && (anchors.margins === anchors.leftMargin))
    property bool isTopRight: (_IsRight && (anchors.margins === anchors.rightMargin))
    property bool isLeftTop: (_IsTop && (anchors.margins === anchors.topMargin))
    property bool isLeftBottom: (_IsBottom && (anchors.margins === anchors.bottomMargin))
    property bool isRightTop: (_IsTop && (anchors.margins === anchors.topMargin))
    property bool isRightBottom: (_IsBottom && (anchors.margins === anchors.bottomMargin))
    property bool isBottomLeft: (_IsLeft && (anchors.margins === anchors.leftMargin))
    property bool isBottomRight: (_IsRight && (anchors.margins === anchors.rightMargin))

    property Region region: (_region)
    Region { id: _region; item: _ }

    color: T.Colors.surface
    property color cardColor: (T.Colors.surface_container)
    property color backgroundColor: (T.Colors.surface)
    property color textColor: (T.Colors.on_surface)

    radius: S.Settings.radius
    property int edge: (S.Settings.edge)
    property int float: (S.Settings.float)
    property int space: (S.Settings.space)

    property int notificationCardWidth: (S.Settings.notificationCardWidth)
    property int notificationCardHeight: (S.Settings.notificationCardHeight)
    property int notificationImageSize: (S.Settings.notificationImageSize)
    property bool notificationIsVertical: (S.Settings.notificationIsVertical)
    property font notificationSummaryFont: (S.Settings.notificationSummaryFont)
    property font notificationBodyFont: (S.Settings.notificationBodyFont)

    property int launcherCardWidth: (S.Settings.launcherCardWidth)
    property int launcherCardHeight: (S.Settings.launcherCardHeight)
    property int launcherInputHeight: (S.Settings.launcherInputHeight)
    property int launcherImageSize: (S.Settings.launcherImageSize)
    property bool launcherInputAtTop: (S.Settings.launcherInputAtTop)
    property bool launcherIsVertical: (S.Settings.launcherIsVertical)
    property font launcherNameFont: (S.Settings.launcherNameFont)
    property font launcherCommentFont: (S.Settings.launcherCommentFont)

    property int clcokWidth: (S.Settings.clcokWidth)
    property int clcokHeight: (S.Settings.clcokHeight)
    property font clockFont: (S.Settings.clockFont)

    property int systemtrayCardWidth: (S.Settings.systemtrayCardWidth)
    property int systemtrayCardHeight: (S.Settings.systemtrayCardHeight)
    property int systemtrayIconSize: (S.Settings.systemtrayIconSize)
    property bool systemtrayIsVertical: (S.Settings.systemtrayIsVertical)

    property bool exclusionModeIgnore: (true)

    anchors.margins: edge + float
    anchors.topMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.topExclusiveZone - edge)
    anchors.leftMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.leftExclusiveZone - edge)
    anchors.rightMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.rightExclusiveZone - edge)
    anchors.bottomMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.bottomExclusiveZone - edge)

    x: (
        _IsLeft ? anchors.leftMargin:
        _IsRight ? parent.width - implicitWidth - anchors.rightMargin: (parent.width - implicitWidth) / 2
    )
    y: (
        _IsTop ? anchors.topMargin:
        _IsBottom ? parent.height - implicitHeight - anchors.bottomMargin: (parent.height - implicitHeight) / 2
    )
    Behavior on x { NA {} }
    Behavior on y { NA {} }


    topLeftRadius: (isTopLeft || isLeftTop) && !float ? 0: radius
    topRightRadius: (isTopRight || isRightTop) && !float ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom) && !float ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom) && !float ? 0: radius

    property bool show: (true)

    width: implicitWidth
    height: implicitHeight
    Behavior on width { NA {} }
    Behavior on height { NA {} }

    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopLeft && !_._IsTop && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopRight && !_._IsTop && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftTop && !_._IsLeft && !_.float ? 1: 0
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftBottom && !_._IsLeft && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightTop && !_._IsRight && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightBottom && !_._IsRight && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomLeft && !_._IsBottom && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomRight && !_._IsBottom && !_.float ? 1: 0
        rotation: 90
    }
}