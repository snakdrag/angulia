import QtQuick

Item {
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
        anchors.top: parent.top
        anchors.right: parent.left
        color: parent.color
        radius: parent.isLeftTop || parent.forceLeftTop ? Math.min(parent.radius, parent.height / 2): 0
        rotation: 90
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.right
        color: parent.color
        radius: parent.isRightTop || parent.forceRightTop ? Math.min(parent.radius, parent.height / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.top
        color: parent.color
        radius: parent.isTopLeft || parent.forceTopLeft ? Math.min(parent.radius, parent.width / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: parent.left
        anchors.bottom: parent.bottom
        color: parent.color
        radius: parent.isLeftBottom || parent.forceLeftBottom ? Math.min(parent.radius, parent.height / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.top
        color: parent.color
        radius: parent.isTopRight || parent.forceTopRight ? Math.min(parent.radius, parent.width / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.left: parent.right
        anchors.bottom: parent.bottom
        color: parent.color
        radius: parent.isRightBottom || parent.forceRightBottom ? Math.min(parent.radius, parent.height / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.left: parent.left
        color: parent.color
        radius: parent.isBottomLeft || parent.forceBottomLeft ? Math.min(parent.radius, parent.width / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.right: parent.right
        color: parent.color
        radius: parent.isBottomRight || parent.forceBottomRight ? Math.min(parent.radius, parent.width / 2): 0
        rotation: 90
    }
}