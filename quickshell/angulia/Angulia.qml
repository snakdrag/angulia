import QtQuick
import "../../settings"

Rectangle {
    id: _

    readonly property string _itemName: ("Angulia")

    property int direction: (1)
    Direction { id: _direction; direction: _.direction}

    x: (
        _direction.isLeft ? edge:
        _direction.isRight ? (parent.width - implicitWidth - edge):
        (parent.width - implicitWidth) / 2
    )
    y: (
        _direction.isTop ? edge:
        _direction.isBottom ? (parent.height - implicitHeight - edge):
        (parent.height - implicitHeight) / 2
    )


    property bool isTopLeft: (false)
    property bool isTopRight: (false)
    property bool isLeftTop: (false)
    property bool isLeftBottom: (false)
    property bool isRightTop: (false)
    property bool isRightBottom: (false)
    property bool isBottomLeft: (false)
    property bool isBottomRight: (false)

    property bool forceTopLeft: (false)
    property bool forceTopRight: (false)
    property bool forceLeftTop: (false)
    property bool forceLeftBottom: (false)
    property bool forceRightTop: (false)
    property bool forceRightBottom: (false)
    property bool forceBottomLeft: (false)
    property bool forceBottomRight: (false)

    readonly property bool isTop: (y + height / 2 < parent.height / 3)
    readonly property bool isLeft: (x + width / 2 < parent.width / 3)
    readonly property bool isRight: (x + width / 2 > parent.width / 3 * 2)
    readonly property bool isBottom: (y + height / 2 > parent.height / 3 * 2)
    property bool isVertical: (false)

    color: Settings.colors.surface
    property color textColor: (Settings.colors.on_surface)
    property color cardColor: (Settings.colors.surface_container)
    property color backgroundColor: (Settings.colors.surface)

    property int edge: (Settings.edge)

    implicitWidth: edge
    implicitHeight: edge

    radius: Settings.radius
    topLeftRadius: (isTopLeft || isLeftTop || forceTopLeft || forceLeftTop) ? 0: radius
    topRightRadius: (isTopRight || isRightTop || forceTopRight || forceRightTop) ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom || forceBottomLeft || forceLeftBottom) ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom || forceBottomRight || forceRightBottom) ? 0: radius

    signal positionChanged()
    onXChanged: positionChanged()
    onYChanged: positionChanged()

    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        color: _.color
        radius: _.isLeftTop || _.forceLeftTop ? Math.min(_.radius, _.height / 2): 0
        rotation: 90
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        color: _.color
        radius: _.isRightTop || _.forceRightTop ? Math.min(_.radius, _.height / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        color: _.color
        radius: _.isTopLeft || _.forceTopLeft ? Math.min(_.radius, _.width / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.left
        anchors.bottom: _.bottom
        color: _.color
        radius: _.isLeftBottom || _.forceLeftBottom ? Math.min(_.radius, _.height / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        color: _.color
        radius: _.isTopRight || _.forceTopRight ? Math.min(_.radius, _.width / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.left: _.right
        anchors.bottom: _.bottom
        color: _.color
        radius: _.isRightBottom || _.forceRightBottom ? Math.min(_.radius, _.height / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        color: _.color
        radius: _.isBottomLeft || _.forceBottomLeft ? Math.min(_.radius, _.width / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        color: _.color
        radius: _.isBottomRight || _.forceBottomRight ? Math.min(_.radius, _.width / 2): 0
        rotation: 90
    }
}