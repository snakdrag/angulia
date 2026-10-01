import QtQuick
import "../custom" as Custom

Rectangle {
    id: _
    anchors.fill: parent

    property int edge: (0)
    property real edgeRadius: (0)
    property color edgeColor: ("#ffffff")

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