import QtQuick
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.systemtray

    implicitWidth: Math.max(_list.contentWidth, cardWidth) + space * 2
    implicitHeight: Math.max(_list.contentHeight, cardHeight) + space * 2

    cardWidth: (isVertical ? bar.height: bar.width) - space * 2
    cardHeight: (isVertical ? bar.width: bar.height) - space * 2

    show: _list.contentWidth !== 0 && _list.contentHeight !== 0

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        color: _.backgroundColor
        radius: _.radius
        List {
            id: _list
            spacing: _.space
            model: SystemTray.items
            isVertical: _.isVertical
            interactive: false
            delegate: Card {
                id: _card
                required property var modelData
                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight
                activeColor: _.textColor
                color: _.cardColor
                radius: _.radius
                imageWidth: _.imageWidth
                imageHeight: _.imageHeight
                imageSource: modelData.icon
                centerIn: true
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