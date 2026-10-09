import QtQuick
import "../../settings"

Rectangle {
    id: _

    readonly property string _itemName: ("Angulia")

    property bool isTopLeft: (false)
    property bool isTopRight: (false)
    property bool isLeftTop: (false)
    property bool isLeftBottom: (false)
    property bool isRightTop: (false)
    property bool isRightBottom: (false)
    property bool isBottomLeft: (false)
    property bool isBottomRight: (false)

    color: Settings.colors.surface

    property int edge: (Settings.edge)

    implicitWidth: edge
    implicitHeight: edge

    radius: Settings.radius
    topLeftRadius: (isTopLeft || isLeftTop) ? 0: radius
    topRightRadius: (isTopRight || isRightTop) ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom) ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom) ? 0: radius

    signal positionChanged()

    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        color: _.color
        radius: Math.min(_.radius, _.height / 2)
        visible: _.isRightTop
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        color: _.color
        radius: Math.min(_.radius, _.width / 2)
        visible: _.isBottomLeft
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        color: _.color
        radius: Math.min(_.radius, _.height / 2)
        visible: _.isLeftTop
        rotation: 90
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        color: _.color
        radius: Math.min(_.radius, _.width / 2)
        visible: _.isBottomRight
        rotation: 90
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        color: _.color
        radius: Math.min(_.radius, _.width / 2)
        visible: _.isTopRight
        rotation: 180
    }
    RoundCorner {
        anchors.right: _.left
        anchors.bottom: _.bottom
        color: _.color
        radius: Math.min(_.radius, _.height / 2)
        visible: _.isLeftBottom
        rotation: 180
    }
    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        color: _.color
        radius: Math.min(_.radius, _.width / 2)
        visible: _.isTopLeft
        rotation: 270
    }
    RoundCorner {
        anchors.left: _.right
        anchors.bottom: _.bottom
        color: _.color
        radius: Math.min(_.radius, _.height / 2)
        visible: _.isRightBottom
        rotation: 270
    }
}