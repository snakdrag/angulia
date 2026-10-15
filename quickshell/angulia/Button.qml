import QtQuick

Rectangle {

    property bool active: (false)
    property color activeColor: ("#000000")

    Rectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: parent.active ? 0.1: 0
        color: parent.activeColor
        Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
        z: 1
    }
}