import QtQuick

Rectangle {
    id: _

    property bool float: (false)

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

    Behavior on color {
        ColorAnimation {
            duration: 1000
            easing.type: Easing.OutCubic
        }
    }

    RoundCorner {
        anchors.left: _.left
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        visible: _.isTopLeft && !_.isTop && !_.float
        rotation: 270
    }
    RoundCorner {
        anchors.right: _.right
        anchors.bottom: _.top
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        visible: _.isTopRight && !_.isTop && !_.float
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        visible: _.isLeftTop && !_.isLeft && !_.float
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.right: _.left
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        visible: _.isLeftBottom && !_.isLeft && !_.float
        rotation: 180
    }
    RoundCorner {
        anchors.top: _.top
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        visible: _.isRightTop && !_.isRight && !_.float
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: _.bottom
        anchors.left: _.right
        radius: Math.min(_.radius, _.height / 2)
        color: _.color
        visible: _.isRightBottom && !_.isRight && !_.float
        rotation: 270
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.left: _.left
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        visible: _.isBottomLeft && !_.isBottom && !_.float
        rotation: 0
    }
    RoundCorner {
        anchors.top: _.bottom
        anchors.right: _.right
        radius: Math.min(_.radius, _.width / 2)
        color: _.color
        visible: _.isBottomRight && !_.isBottom && !_.float
        rotation: 90
    }
}