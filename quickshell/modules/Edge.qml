import QtQuick
import "../custom" as Custom

Rectangle {
    id: _
    anchors.fill: parent

    color: "transparent"
    border.color: _rectangle.color
    border.width: _rectangle.edge

    Custom.Rectangle {
        id: _rectangle
        show: false
    }

    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: _rectangle.edge
        radius: _rectangle.radius
        color: _rectangle.color
        rotation: 0
    }
    Custom.RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: _rectangle.edge
        radius: _rectangle.radius
        color: _rectangle.color
        rotation: 90
    }
    Custom.RoundCorner {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: _rectangle.edge
        radius: _rectangle.radius
        color: _rectangle.color
        rotation: 270
    }
    Custom.RoundCorner {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _rectangle.edge
        radius: _rectangle.radius
        color: _rectangle.color
        rotation: 180
    }
}