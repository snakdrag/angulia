import QtQuick

Item {

    anchors.fill: parent

    property real radius: (parent.radius)
    property color color: (parent.color)

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

    readonly property real widthRadius: Math.min(this.radius, this.width / 2)
    readonly property real heightRadius: Math.min(this.radius, this.height / 2)
    readonly property real finalRadius: Math.min(this.widthRadius, this.heightRadius)

    RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.left
        color: parent.color
        radius: parent.isLeftTop || parent.forceLeftTop ? parent.heightRadius: 0
        rotation: 90
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.right
        color: parent.color
        radius: parent.isRightTop || parent.forceRightTop ? parent.heightRadius: 0
        rotation: 0
    }
    RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.top
        color: parent.color
        radius: parent.isTopLeft || parent.forceTopLeft ? parent.widthRadius: 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: parent.left
        anchors.bottom: parent.bottom
        color: parent.color
        radius: parent.isLeftBottom || parent.forceLeftBottom ? parent.heightRadius: 0
        rotation: 180
    }
    RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.top
        color: parent.color
        radius: parent.isTopRight || parent.forceTopRight ? parent.widthRadius: 0
        rotation: 180
    }
    RoundCorner {
        anchors.left: parent.right
        anchors.bottom: parent.bottom
        color: parent.color
        radius: parent.isRightBottom || parent.forceRightBottom ? parent.heightRadius: 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.left: parent.left
        color: parent.color
        radius: parent.isBottomLeft || parent.forceBottomLeft ? parent.widthRadius: 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.right: parent.right
        color: parent.color
        radius: parent.isBottomRight || parent.forceBottomRight ? parent.widthRadius: 0
        rotation: 90
    }
}