import QtQuick
import "../angulia"

Item {
    anchors.fill: parent
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: this.edge
        anchors.topMargin: 0
    }
    Angulia {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: this.edge
        anchors.bottomMargin: 0
    }
    Angulia {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 0
        radius: 0
        roundcorners.forceLeftTop: true
        roundcorners.forceLeftBottom: true
    }
    Angulia {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0
        radius: 0
        roundcorners.forceRightTop: true
        roundcorners.forceRightBottom: true
    }
}