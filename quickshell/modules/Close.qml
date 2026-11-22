import QtQuick
import Quickshell
import "../components"
import "../states" as States

Button {
    id: _

    property bool show: (false)
    readonly property Region region: (_region)

    z: -1
    implicitWidth: this.show ? parent.width: 0
    implicitHeight: this.show ? parent.height: 0

    color: "transparent"

    mouseArea.cursorShape: Qt.ArrowCursor

    onClicked: {
        States.Popup.close()
        States.Ipc.closeAll()
    }

    Region { id: _region; item: _ }
}
