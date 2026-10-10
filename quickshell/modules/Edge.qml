import QtQuick
import "../angulia"

Item {
    anchors.fill: parent
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: edge
        anchors.rightMargin: edge
    }
    Angulia {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: edge
        anchors.rightMargin: edge
    }
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        forceLeftTop: true
        forceLeftBottom: true
    }
    Angulia {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        forceRightTop: true
        forceRightBottom: true
    }
}