import QtQuick

Rectangle {
    property bool show: (false)

    width: parent.width
    height: parent.height
    topLeftRadius: parent.topLeftRadius
    topRightRadius: parent.topRightRadius
    bottomLeftRadius: parent.bottomLeftRadius
    bottomRightRadius: parent.bottomRightRadius

    opacity: show ? 0.1: 0

    Behavior on x { NA {} }
    Behavior on y { NA {} }
    Behavior on opacity { NA {} }
}