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

    property real topLeftRadius: (this.radius)
    property real topRightRadius: (this.radius)
    property real leftTopRadius: (this.radius)
    property real leftBottomRadius: (this.radius)
    property real rightTopRadius: (this.radius)
    property real rightBottomRadius: (this.radius)
    property real bottomLeftRadius: (this.radius)
    property real bottomRightRadius: (this.radius)

    readonly property real widthRadius: Math.min(this.radius, this.width / 2)
    readonly property real heightRadius: Math.min(this.radius, this.height / 2)
    readonly property real finalRadius: Math.min(this.widthRadius, this.heightRadius)

    RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.top
        radius: parent.isTopLeft ? Math.min(parent.widthRadius, parent.topLeftRadius): 0
        color: parent.color
        rotation: 270
    }
    RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.top
        radius: parent.isTopRight ? Math.min(parent.widthRadius, parent.topRightRadius): 0
        color: parent.color
        rotation: 180
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.left
        radius: parent.isLeftTop ? Math.min(parent.heightRadius, parent.leftTopRadius): 0
        color: parent.color
        rotation: 90
    }
    RoundCorner {
        anchors.right: parent.left
        anchors.bottom: parent.bottom
        radius: parent.isLeftBottom ? Math.min(parent.heightRadius, parent.leftBottomRadius): 0
        color: parent.color
        rotation: 180
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.right
        radius: parent.isRightTop ? Math.min(parent.heightRadius, parent.rightTopRadius): 0
        color: parent.color
        rotation: 0
    }
    RoundCorner {
        anchors.left: parent.right
        anchors.bottom: parent.bottom
        radius: parent.isRightBottom ? Math.min(parent.heightRadius, parent.rightBottomRadius): 0
        color: parent.color
        rotation: 270
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.left: parent.left
        radius: parent.isBottomLeft ? Math.min(parent.widthRadius, parent.bottomLeftRadius): 0
        color: parent.color
        rotation: 0
    }
    RoundCorner {
        anchors.top: parent.bottom
        anchors.right: parent.right
        radius: parent.isBottomRight ? Math.min(parent.widthRadius, parent.bottomRightRadius): 0
        color: parent.color
        rotation: 90
    }
}