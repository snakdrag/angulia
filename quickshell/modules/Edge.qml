import QtQuick
import "../custom" as Custom
import qs.angulia.theme

Item {
    id: _
    
    anchors.fill: parent

    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property int edge: (Settings.edge)
    
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: _.edge
        color: _.color
    }
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: _.edge
        anchors.bottomMargin: _.edge
        implicitWidth: _.edge
        color: _.color
        radius: _.radius
    }
    Custom.Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: _.edge
        anchors.bottomMargin: _.edge
        implicitWidth: _.edge
        color: _.color
        radius: _.radius
    }
    Custom.Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitHeight: _.edge
        color: _.color
    }
}