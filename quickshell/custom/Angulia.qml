import QtQuick
import "../../settings" as S

Rectangle {
    id: _

    // directions
    property int direction: (1)

    S.Direction { id: _direction; direction: _.direction}
    readonly property var directions: (_direction)

    property bool isTop: (directions.isTop)
    property bool isLeft: (directions.isLeft)
    property bool isRight: (directions.isRight)
    property bool isBottom: (directions.isBottom)

    property bool isTopLeft: (isLeft && (anchors.margins === anchors.leftMargin))
    property bool isTopRight: (isRight && (anchors.margins === anchors.rightMargin))
    property bool isLeftTop: (isTop && (anchors.margins === anchors.topMargin))
    property bool isLeftBottom: (isBottom && (anchors.margins === anchors.bottomMargin))
    property bool isRightTop: (isTop && (anchors.margins === anchors.topMargin))
    property bool isRightBottom: (isBottom && (anchors.margins === anchors.bottomMargin))
    property bool isBottomLeft: (isLeft && (anchors.margins === anchors.leftMargin))
    property bool isBottomRight: (isRight && (anchors.margins === anchors.rightMargin))

    // animations
    Behavior on x { NA {} }
    Behavior on y { NA {} }
    Behavior on width { NA {} }
    Behavior on height { NA {} }

    // contentWidth and contentHeight
    property int _contentWidth: (0)
    property int _contentHeight: (0)
    readonly property int contentWidth: (
        Math.min(_contentWidth, parent.width / 2 - edge - space * 2 - (directions.isTopBottom ? 0: float))
    )
    readonly property int contentHeight: (
        Math.min(_contentHeight, parent.height / 2 - edge - space * 2 - (directions.isLeftRight ? 0: float))
    )
    readonly property bool noContent: (contentWidth === 0 || contentHeight === 0)

    // colors
    color: S.Settings.colors.surface
    property color cardColor: (S.Settings.colors.surface_container)
    property color backgroundColor: (S.Settings.colors.surface)
    property color textColor: (S.Settings.colors.on_surface)

    // fonts
    readonly property var fonts: (S.Settings.fonts)

    // settings
    radius: S.Settings.radius
    property int edge: (S.Settings.edge)
    property int float: (S.Settings.float)
    property int space: (S.Settings.space)
    property bool show: (true)
    property bool isVertical: (false)

    // margins
    property bool exclusionModeIgnore: (true)
    anchors.margins: edge + float
    anchors.topMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.topExclusiveZone - edge)
    anchors.leftMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.leftExclusiveZone - edge)
    anchors.rightMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.rightExclusiveZone - edge)
    anchors.bottomMargin: anchors.margins + (exclusionModeIgnore ? 0: S.Settings.bottomExclusiveZone - edge)

    // place
    x: (
        directions.isLeft ? anchors.leftMargin:
        directions.isRight ? (parent.width - implicitWidth - anchors.rightMargin):
        (parent.width - implicitWidth) / 2
    )
    y: (
        directions.isTop ? anchors.topMargin:
        directions.isBottom ? (parent.height - implicitHeight - anchors.bottomMargin):
        (parent.height - implicitHeight) / 2
    )

    // size
    width: implicitWidth
    height: implicitHeight

    // radius
    topLeftRadius: (isTopLeft || isLeftTop) && !float ? 0: radius
    topRightRadius: (isTopRight || isRightTop) && !float ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom) && !float ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom) && !float ? 0: radius

    // RoundCorners
    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopLeft && _.directions.notTop && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isTopRight && _.directions.notTop && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftTop && _.directions.notLeft && !_.float ? 1: 0
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isLeftBottom && _.directions.notLeft && !_.float ? 1: 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightTop && _.directions.notRight && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        opacity: _.isRightBottom && _.directions.notRight && !_.float ? 1: 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomLeft && _.directions.notBottom && !_.float ? 1: 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        opacity: _.isBottomRight && _.directions.notBottom && !_.float ? 1: 0
        rotation: 90
    }
}