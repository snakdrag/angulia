import QtQuick

Rectangle {
    id: _
    anchors.fill: parent
    
    topLeftRadius: parent.topLeftRadius
    topRightRadius: parent.topRightRadius
    bottomLeftRadius: parent.bottomLeftRadius
    bottomRightRadius: parent.bottomRightRadius

    property bool show: (false)

    opacity: show ? 0.1: 0

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
}