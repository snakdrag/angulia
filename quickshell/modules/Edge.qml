import QtQuick
import "../angulia"

Item {
    anchors.fill: parent
    Angulia {
        anchors.margins: edge
        anchors.topMargin: 0
        implicitWidth: parent.width - edge * 2
    }
    Angulia {
        customY: parent.height
        anchors.margins: edge
        anchors.bottomMargin: 0
        implicitWidth: parent.width - edge * 2
    }
    Angulia {
        anchors.margins: 0
        implicitHeight: parent.height
        forceLeftTop: true
        forceLeftBottom: true
    }
    Angulia {
        customX: parent.width
        anchors.margins: 0
        implicitHeight: parent.height
        forceRightTop: true
        forceRightBottom: true
    }
}