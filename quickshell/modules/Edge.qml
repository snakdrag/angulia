import QtQuick
import "../custom" as Custom
import qs.angulia.theme

Rectangle {
    id: _
    anchors.fill: parent

    property real edgeRadius: (Settings.radius)
    property color edgeColor: (Colors.surface)
    property int edge: (Settings.edge)

    color: "transparent"
    border.color: edgeColor
    border.width: edge

    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: _.edge
        radius: _.edgeRadius
        color: _.edgeColor
        rotation: 0
    }
    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: _.edge
        radius: _.edgeRadius
        color: _.edgeColor
        rotation: 90
    }
    Custom.RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: _.edge
        radius: _.edgeRadius
        color: _.edgeColor
        rotation: 270
    }
    Custom.RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _.edge
        radius: _.edgeRadius
        color: _.edgeColor
        rotation: 180
    }
}