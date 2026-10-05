import QtQuick

Rectangle {
    property bool show: (false)
    anchors.fill: parent

    topLeftRadius: parent.topLeftRadius
    topRightRadius: parent.topRightRadius
    bottomLeftRadius: parent.bottomLeftRadius
    bottomRightRadius: parent.bottomRightRadius

    opacity: show ? 0.1: 0
    Behavior on opacity { NA {} }
}