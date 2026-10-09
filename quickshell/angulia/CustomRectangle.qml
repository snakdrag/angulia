import QtQuick

Rectangle {
    id: _

    property bool active: (false)
    property color activeColor: ("#000000")

    Rectangle {
        anchors.fill: _

        topLeftRadius: _.topLeftRadius
        topRightRadius: _.topRightRadius
        bottomLeftRadius: _.bottomLeftRadius
        bottomRightRadius: _.bottomRightRadius

        opacity: _.active ? 0.1: 0
        color: _.activeColor
    }
}