import QtQuick
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.systemtray

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: Math.max(_list.contentHeight, this.cardHeight) + this.space * 2

    cardWidth: (this.isVertical ? this.bar.height: this.bar.width) - this.space * 2
    cardHeight: (this.isVertical ? this.bar.width: this.bar.height) - this.space * 2

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
                required property var modelData
                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight
                activeColor: _.textColor
                color: _.cardColor
                radius: _.radius
                imageWidth: _.imageWidth
                imageHeight: _.imageHeight
                imageSource: this.modelData.icon
                centerIn: true
                Mouse {
                    onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton)
                    {
                        parent.modelData.activate()
                    }
                    else if (mouse.button === Qt.MiddleButton)
                    {
                        parent.modelData.secondaryActivate()
                    }
                    else if (mouse.button === Qt.RightButton && parent.modelData.hasMenu)
                    {
                        // parent.modelData.display(_Top, _.x + parent.x, _.y + parent.y)
                    }}
                    onEntered: parent.active = true
                    onExited: parent.active = false
                }
            }
        }
    }
}