import QtQuick

Item {
    id: _
    anchors.fill: parent

    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        color: _.parent.color
        radius: _.parent.isLeftTop || _.parent.forceLeftTop ? Math.min(_.parent.radius, _.height / 2): 0
        rotation: 90
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        color: _.parent.color
        radius: _.parent.isRightTop || _.parent.forceRightTop ? Math.min(_.parent.radius, _.height / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        color: _.parent.color
        radius: _.parent.isTopLeft || _.parent.forceTopLeft ? Math.min(_.parent.radius, _.width / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.left
        anchors.bottom: _.bottom
        color: _.parent.color
        radius: _.parent.isLeftBottom || _.parent.forceLeftBottom ? Math.min(_.parent.radius, _.height / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        color: _.parent.color
        radius: _.parent.isTopRight || _.parent.forceTopRight ? Math.min(_.parent.radius, _.width / 2): 0
        rotation: 180
    }
    RoundCorner {
        anchors.left: _.right
        anchors.bottom: _.bottom
        color: _.parent.color
        radius: _.parent.isRightBottom || _.parent.forceRightBottom ? Math.min(_.parent.radius, _.height / 2): 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        color: _.parent.color
        radius: _.parent.isBottomLeft || _.parent.forceBottomLeft ? Math.min(_.parent.radius, _.width / 2): 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        color: _.parent.color
        radius: _.parent.isBottomRight || _.parent.forceBottomRight ? Math.min(_.parent.radius, _.width / 2): 0
        rotation: 90
    }
}