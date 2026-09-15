import QtQuick
import "../custom" as Custom

Item {
    id: _
    anchors.fill: parent

    property real radius: (0)
    property color color: ("#ffffff")
    property int edge: (0)

    Custom.RoundRectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: _.edge
        rectangleHeight: _.edge
        radius: _.radius
        color: _.color
        isTopRight: true
        isLeftTop: true
        isLeftBottom: true
        isBottomRight: true
    }
    Custom.RoundRectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _.edge
        rectangleWidth: _.edge
        radius: _.radius
        color: _.color
        isTopLeft: true
        isTopRight: true
        isLeftBottom: true
        isRightBottom: true
    }
    Custom.RoundRectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: _.edge
        rectangleHeight: _.edge
        radius: _.radius
        color: _.color
        isTopLeft: true
        isRightTop: true
        isRightBottom: true
        isBottomLeft: true
    }
    Custom.RoundRectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: _.edge
        rectangleWidth: _.edge
        radius: _.radius
        color: _.color
        isBottomLeft: true
        isBottomRight: true
        isLeftTop: true
        isRightTop: true
    }
}