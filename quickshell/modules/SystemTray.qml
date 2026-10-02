import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../custom" as Custom

Custom.Rectangle {
    id: _

    implicitWidth: contentHeight !== 0 && contentWidth !== 0 ? Math.max(contentWidth, 30) + _.space * 2: 0
    implicitHeight:  contentHeight !== 0 && contentWidth !== 0 ? Math.max(contentHeight, 30) + _.space * 2: 0

    readonly property int contentWidth: (Math.min(
        _list.contentWidth,
        (
            _IsTopBottom ?
            parent.width / 2 - edge - space:
            parent.width / 2 - edge - space - float
        )
    ))
    readonly property int contentHeight: (Math.min(
        _list.contentHeight,
        (
            _IsLeftRight ?
            parent.height / 2 - edge - space:
            parent.height / 2 - edge - space - float
        )
    ))

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        color: "transparent"
        radius: _.radius
        ListView {
            id: _list
            anchors.fill: parent
            spacing: _.space
            model: SystemTray.items
            orientation: ListView.Horizontal
            displaced: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
            delegate: Rectangle {
                id: _card
                required property var modelData
                property bool hovered: false
                implicitWidth: 30
                implicitHeight: 30
                radius: _.radius
                color: _.cardColor
                Image {
                    anchors.fill: parent
                    anchors.margins: _.space / 2
                    source: _card.modelData.icon || ""
                }
                Custom.Cover {
                    show: _card.hovered
                    color: _.textColor
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {_card.modelData.activate()} 
                        else if (mouse.button === Qt.MiddleButton) {_card.modelData.secondaryActivate()}
                        else if (mouse.button === Qt.RightButton && _card.modelData.hasMenu) {
                            _card.modelData.display(_top, _.x + _card.x, _.y + _card.y)
                        }
                    }
                    onEntered: _card.hovered = true
                    onExited: _card.hovered = false
                }
            }
        }
    }
}