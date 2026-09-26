import QtQuick
import "../custom" as Custom

Custom.Angulia {
    id: _
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: _.edge
        implicitWidth: parent.width
        implicitHeight: _.edge
        radius: _.radius
        color: _.color
        isTopRight: true
        isLeftTop: true
        isLeftBottom: true
        isBottomRight: true
    }
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _.edge
        implicitWidth: _.edge
        implicitHeight: parent.height
        radius: _.radius
        color: _.color
        isTopLeft: true
        isTopRight: true
        isLeftBottom: true
        isRightBottom: true
    }
    Custom.Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: _.edge
        implicitWidth: parent.width
        implicitHeight: _.edge
        radius: _.radius
        color: _.color
        isTopLeft: true
        isRightTop: true
        isRightBottom: true
        isBottomLeft: true
    }
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: _.edge
        implicitWidth: _.edge
        implicitHeight: parent.height
        radius: _.radius
        color: _.color
        isBottomLeft: true
        isBottomRight: true
        isLeftTop: true
        isRightTop: true
    }
}