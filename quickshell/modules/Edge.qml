import QtQuick
import "../components"

Item {

    anchors.fill: parent

    property int edge: (5)
    property real radius: (12)

    Panel {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.edge
        anchors.rightMargin: parent.edge
        implicitHeight: parent.edge
        radius: parent.radius
    }
    Panel {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.edge
        anchors.rightMargin: parent.edge
        implicitHeight: parent.edge
        radius: parent.radius
    }
    Panel {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        implicitWidth: parent.edge
    }
    Panel {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitWidth: parent.edge
    }
}