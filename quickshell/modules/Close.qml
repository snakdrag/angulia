import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {

    customX: parent.width / 2
    customY: parent.height / 2
    z: -1
    maxWidth: parent.width
    maxHeight: parent.height
    implicitWidth: parent.width
    implicitHeight: parent.height

    color: "transparent"
    edge: 0
    float: 0

    MouseArea {

        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onClicked: {
            States.Popup.close()
            States.Ipc.closeAll()
        }
    }
}
