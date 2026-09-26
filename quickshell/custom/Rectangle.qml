import QtQuick

Rectangle {
    id: _

    property bool float: (false)

    property bool isTopLeft: (false)
    property bool isTopRight: (false)
    property bool isLeftTop: (false)
    property bool isLeftBottom: (false)
    property bool isRightTop: (false)
    property bool isRightBottom: (false)
    property bool isBottomLeft: (false)
    property bool isBottomRight: (false)

    property bool isTop: (!isTopLeft && !isTopRight || anchors.top === parent.top)
    property bool isLeft: (!isLeftTop && !isLeftBottom || anchors.left === parent.left)
    property bool isRight: (!isRightTop && !isRightBottom || anchors.right === parent.right)
    property bool isBottom: (!isBottomLeft && !isBottomRight || anchors.bottom === parent.bottom)

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