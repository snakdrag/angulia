import QtQuick
import Quickshell
import qs.angulia.theme

Rectangle {
    id: _

    color: Colors.surface
    property color cardColor: (Colors.surface_container)
    property color textColor: (Colors.on_surface)

    property int notificationCardWidth: (Settings.notificationCardWidth)
    property int notificationCardHeight: (Settings.notificationCardHeight)
    property bool notificationIsVertical: (Settings.notificationIsVertical)
    property font notificationSummaryFont: (Settings.notificationSummaryFont)
    property font notificationBodyFont: (Settings.notificationBodyFont)

    property int launcherCardWidth: (Settings.launcherCardWidth)
    property int launcherCardHeight: (Settings.launcherCardHeight)
    property int launcherInputHeight: (Settings.launcherInputHeight)
    property bool launcherInputAtTop: (Settings.launcherInputAtTop)
    property bool launcherInputIsVertical: (Settings.launcherInputIsVertical)
    property font launcherNameFont: (Settings.launcherNameFont)
    property font launcherCommentFont: (Settings.launcherCommentFont)

    property int clcokWidth: (Settings.clcokWidth)
    property int clcokHeight: (Settings.clcokHeight)
    property font clockFont: (Settings.clockFont)

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

    anchors.top: _IsTop ? parent.top: undefined
    anchors.left: _IsLeft ? parent.left: undefined
    anchors.right: _IsRight ? parent.right: undefined
    anchors.bottom: _IsBottom ? parent.bottom: undefined
    anchors.horizontalCenter: _IsTopBottom ? parent.horizontalCenter: undefined
    anchors.verticalCenter: _IsLeftRight ? parent.verticalCenter: undefined
    anchors.margins: edge + float

    property bool isTop: (anchors.top === parent.top)
    property bool isLeft: (anchors.left === parent.left)
    property bool isRight: (anchors.right === parent.right)
    property bool isBottom: (anchors.bottom === parent.bottom)

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

    property bool show: (true)

    opacity: show ? 1: 0

    property Region region: (_region)
    Region { id: _region; item: _ }

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on implicitHeight {
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