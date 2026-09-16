import QtQuick
import Quickshell
import Quickshell.Widgets
import "../custom" as Custom
import "../services" as Services
import qs.angulia.theme
import qs.angulia.quickshell.settings

Item {
    id: _
    anchors.fill: parent
    property int direction: (Decorations.notificationDirection % 8)
    readonly property bool isTop: (
        direction === 0 ||
        direction === 1 ||
        direction === 2
    )
    readonly property bool isLeft: (
        direction === 0 ||
        direction === 6 ||
        direction === 7
    )
    readonly property bool isRight: (
        direction === 2 ||
        direction === 3 ||
        direction === 4 
    )
    readonly property bool isBottom: (
        direction === 4 ||
        direction === 5 ||
        direction === 6 
    )

    readonly property bool isTopBottom: (
        direction === 1 ||
        direction === 5
    )
    readonly property bool isLeftRight: (
        direction === 3 ||
        direction === 7
    )

    readonly property bool isTopLeft: (
        direction === 0 ||
        direction === 1 ||
        direction === 7 
    )
    readonly property bool isTopRight: (
        direction === 1 ||
        direction === 2 ||
        direction === 3 
    )
    readonly property bool isBottomLeft: (
        direction === 5 ||
        direction === 6 ||
        direction === 7 
    )
    readonly property bool isBottomRight: (
        direction === 3 ||
        direction === 4 ||
        direction === 5 
    )
    readonly property Region region: (_region)
    Region {
        id: _region
        item: _center
    }
    ClippingRectangle {
        id: _center
        implicitWidth: Decorations.notificationWidth
        implicitHeight: Decorations.notificationHeight
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.margins: Decorations.edge + Decorations.notificationSpace
        radius: Decorations.radius
        color: "transparent"
        ListView {
            id: _list
            anchors.fill: parent
            spacing: Decorations.notificationSpace
            model: Services.Notifications.server.trackedNotifications
            delegate: Rectangle {
                id: _card
                required property var modelData
                implicitWidth: Decorations.notificationWidth
                implicitHeight: Decorations.notificationHeight
                radius: Decorations.radius
                color: Colors.surface_container
                Item {
                    anchors.fill: parent
                    anchors.margins: Decorations.notificationSpace
                    Text {
                        id: _summary
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        text: modelData.summary
                        color: Colors.on_surface
                        font.bold: true
                        elide: Text.ElideRight
                    }
                    Text {
                        id: _body
                        anchors.top: _summary.bottom
                        text: modelData.body
                        color: Colors.on_surface
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}