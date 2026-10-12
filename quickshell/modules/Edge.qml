import QtQuick
import "../angulia"

Item {
    anchors.fill: parent
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: edge
        anchors.topMargin: 0
    }
    Angulia {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: edge
        anchors.bottomMargin: 0
    }
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 0
        forceLeftTop: true
        forceLeftBottom: true
    }
    Angulia {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0
        forceRightTop: true
        forceRightBottom: true
    }
}