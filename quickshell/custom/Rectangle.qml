import QtQuick

Rectangle {
    id: _

    property color textColor: ("#ffffff")
    property color cardColor: ("#222222")
    property color backgroundColor: ("#000000")

    // animations
    Behavior on x { NA {} }
    Behavior on y { NA {} }

    // active action
    property bool active: (false)
    Rectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: _.active ? 0.1: 0
        color: _.textColor

        // animations
        Behavior on opacity { NA {} }
    }
}