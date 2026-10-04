import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../custom" as Custom

Custom.Rectangle {
    id: _

    implicitWidth: contentHeight === 0 || contentWidth === 0 ? 0: Math.max(contentWidth, systemtrayCardWidth) + _.space * 2
    implicitHeight:  contentHeight === 0 || contentWidth === 0 ? 0: Math.max(contentHeight, systemtrayCardHeight) + _.space * 2

    readonly property int contentWidth: (Math.min(
        _list.contentWidth,
        (
            _IsTopBottom ?
            parent.width / 2 - edge - space * 2:
            parent.width / 2 - edge - space * 2 - float
        )
    ))
    readonly property int contentHeight: (Math.min(
        _list.contentHeight,
        (
            _IsLeftRight ?
            parent.height / 2 - edge - space * 2:
            parent.height / 2 - edge - space * 2 - float
        )
    ))

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        color: _.backgroundColor
        radius: _.radius
        ListView {
            id: _list
            anchors.fill: parent
            spacing: _.space
            model: SystemTray.items
            orientation: _.systemtrayIsVertical ? ListView.Vertical: ListView.Horizontal
            interactive: false
            displaced: Transition { Custom.NA { properties: "x, y" } }
            delegate: Rectangle {
                id: _card
                required property var modelData
                property bool hovered: false
                implicitWidth: _.systemtrayCardWidth
                implicitHeight: _.systemtrayCardHeight
                radius: _.radius
                color: _.cardColor
                Image {
                    anchors.centerIn: parent
                    width: _.systemtrayIconSize
                    height: _.systemtrayIconSize
                    source: _card.modelData.icon || ""
                    fillMode: Image.PreserveAspectFit
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