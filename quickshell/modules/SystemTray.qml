import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../custom" as Custom
import "../angulia"
import "../../settings"

Angulia {
    id: _

    property var systemtray: (Settings.systemtray)
    readonly property var bar: (Settings.bar)

    implicitWidth: noContent ? 0: Math.max(contentWidth, cardWidth) + space * 2
    implicitHeight: noContent ? 0: Math.max(contentHeight, cardHeight) + space * 2

    cardWidth: (isVertical ? bar.width: bar.height) - space * 2
    cardHeight: (isVertical ? bar.height: bar.width) - space * 2

    customX: parent.width
    customY: parent.height

    imageSize: (systemtray.iconSize)

    _contentWidth: _list.contentWidth
    _contentHeight: _list.contentHeight


    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        color: _.backgroundColor
        radius: _.radius
        CustomListView {
            id: _list
            spacing: _.space
            model: SystemTray.items
            isVertical: _.isVertical
            interactive: false
            delegate: CustomRectangle {
                id: _card
                required property var modelData
                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight
                color: _.cardColor
                activeColor: _.textColor
                radius: _.radius
                Image {
                    anchors.centerIn: parent
                    width: _.imageSize
                    height: _.imageSize
                    source: _card.modelData.icon || ""
                    fillMode: Image.PreserveAspectFit
                }
                CustomMouseArea {
                    onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton)
                    {
                        _card.modelData.activate()
                    }
                    else if (mouse.button === Qt.MiddleButton)
                    {
                        _card.modelData.secondaryActivate()
                    }
                    else if (mouse.button === Qt.RightButton && _card.modelData.hasMenu)
                    {
                        _card.modelData.display(_Top, _.x + _card.x, _.y + _card.y)
                    }}
                    onEntered: _card.active = true
                    onExited: _card.active = false
                }
            }
        }
    }
}