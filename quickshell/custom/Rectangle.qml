import QtQuick

Rectangle {
    id: _

    property bool active: (false)
    property color cardColor: ("#222222")
    property color textColor: ("#ffffff")

    // active action
    Rectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: _.active ? 0.1: 0
        color: _.textColor

        Behavior on opacity { NA {} }
    }
}