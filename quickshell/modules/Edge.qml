import QtQuick
import "../components"

Item {
    anchors.fill: parent
    Panel {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 0
        isVertical: false
        isHorizontal: true
        exclusiveZones: ({top: this.edge})
    }
    Panel {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        isVertical: false
        isHorizontal: true
        exclusiveZones: ({bottom: this.edge})
    }
    Panel {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 0
        radius: 0
        isVertical: true
        isHorizontal: false
        exclusiveZones: ({left: this.edge})
    }
    Panel {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0
        radius: 0
        isVertical: true
        isHorizontal: false
        exclusiveZones: ({right: this.edge})
    }
}