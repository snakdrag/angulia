import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../custom" as Custom
import qs.angulia.theme

Custom.Item {
    id: _
    anchors.fill: parent
    direction: 1

    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property color textColor: (Colors.on_surface)
    property int edge: (Settings.edge)
    property int float: (Settings.float)
    property int space: (Settings.launcherSpace)

    anchors.margins: edge + float

    property bool opened: (false)

    readonly property int contentHeight: (Math.min(1000, parent.height / 2 - _.space * 2 - 50))

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open() {
            _.opened = true
            // _search.forceActiveFocus()
        }
        function close() {
            _.opened = false
        }
        function toggle() {
            if(!_.opened){ open() }
            else { close() }
        }
    }
    Custom.Rectangle {
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined

        implicitWidth: _.opened ? 300 + _.space * 2: 0
        implicitHeight: _.opened ? (_.contentHeight === 0 ? 50: _.contentHeight + _.space + 50): 0

        float: _.float
        radius: _.radius
        color: _.color
    }
}