import QtQuick
import "../custom" as Custom

Rectangle {
    id: _
    anchors.fill: parent

    Custom.Angulia { id: _angulia; show: false }
    color: "transparent"
    border.color: _angulia.color
    border.width: _angulia.edge

    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: _angulia.edge
        radius: _angulia.radius
        color: _angulia.color
        rotation: 0
    }
    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: _angulia.edge
        radius: _angulia.radius
        color: _angulia.color
        rotation: 90
    }
    Custom.RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: _angulia.edge
        radius: _angulia.radius
        color: _angulia.color
        rotation: 270
    }
    Custom.RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _angulia.edge
        radius: _angulia.radius
        color: _angulia.color
        rotation: 180
    }
}