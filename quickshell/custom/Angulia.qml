import QtQuick
import "../../settings" as S

Rectangle {
    id: _

    // directions
    property int direction: (1)

    S.Direction { id: _direction; direction: _.direction}
    readonly property var directions: (_direction)

    property bool isTopLeft: (directions.isLeft && (anchors.margins === anchors.leftMargin))
    property bool isTopRight: (directions.isRight && (anchors.margins === anchors.rightMargin))
    property bool isLeftTop: (directions.isTop && (anchors.margins === anchors.topMargin))
    property bool isLeftBottom: (directions.isBottom && (anchors.margins === anchors.bottomMargin))
    property bool isRightTop: (directions.isTop && (anchors.margins === anchors.topMargin))
    property bool isRightBottom: (directions.isBottom && (anchors.margins === anchors.bottomMargin))
    property bool isBottomLeft: (directions.isLeft && (anchors.margins === anchors.leftMargin))
    property bool isBottomRight: (directions.isRight && (anchors.margins === anchors.rightMargin))

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
    color: Data.colors.surface
    property color cardColor: (Data.colors.surface_container)
    property color backgroundColor: (Data.colors.surface)
    property color textColor: (Data.colors.on_surface)

    // fonts
    readonly property var fonts: (Data.settings.fonts)

    // settings
    radius: Data.settings.radius
    property int edge: (Data.settings.edge)
    property int float: (Data.settings.float)
    property int space: (Data.settings.space)
    property bool show: (true)
    property bool isVertical: (true)

    // margins
    property bool exclusionModeIgnore: (true)
    anchors.margins: edge + float
    anchors.topMargin: anchors.margins + (exclusionModeIgnore ? 0: Data.settings.topExclusiveZone - edge)
    anchors.leftMargin: anchors.margins + (exclusionModeIgnore ? 0: Data.settings.leftExclusiveZone - edge)
    anchors.rightMargin: anchors.margins + (exclusionModeIgnore ? 0: Data.settings.rightExclusiveZone - edge)
    anchors.bottomMargin: anchors.margins + (exclusionModeIgnore ? 0: Data.settings.bottomExclusiveZone - edge)

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