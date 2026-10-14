import QtQuick

Item {
    id: _
    anchors.fill: parent

    property real radius: (parent.radius)
    property color color: (parent.color)

    property bool isTopLeft: (parent.isTopLeft)
    property bool isTopRight: (parent.isTopRight)
    property bool isLeftTop: (parent.isLeftTop)
    property bool isLeftBottom: (parent.isLeftBottom)
    property bool isRightTop: (parent.isRightTop)
    property bool isRightBottom: (parent.isRightBottom)
    property bool isBottomLeft: (parent.isBottomLeft)
    property bool isBottomRight: (parent.isBottomRight)

    property bool forceTopLeft: (parent.forceTopLeft)
    property bool forceTopRight: (parent.forceTopRight)
    property bool forceLeftTop: (parent.forceLeftTop)
    property bool forceLeftBottom: (parent.forceLeftBottom)
    property bool forceRightTop: (parent.forceRightTop)
    property bool forceRightBottom: (parent.forceRightBottom)
    property bool forceBottomLeft: (parent.forceBottomLeft)
    property bool forceBottomRight: (parent.forceBottomRight)

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