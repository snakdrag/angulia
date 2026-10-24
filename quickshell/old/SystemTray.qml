import QtQuick
import Quickshell
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

    Rectangle {
        anchors.fill: parent
        anchors.margins: _.space
        color: _.backgroundColor
        radius: _.radius
        List {
            id: _list
            spacing: _.space
            model: ScriptModel { values: SystemTray.items.values }
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
                imageSource: this.modelData.icon
                asynchronous: false
                centerIn: true
                mouseArea.onClicked: mouse => {
                if (mouse.button === Qt.LeftButton)
                {
                    _popup.close()
                    this.modelData.activate()
                }
                else if (mouse.button === Qt.MiddleButton)
                {
                    _popup.close()
                    this.modelData.secondaryActivate()
                }
                else if (mouse.button === Qt.RightButton && this.modelData.hasMenu)
                {
                    _popup.call(_.x + _.space + this.x + this.width / 2, _.y + _.space + this.y + this.height / 2, this.modelData.menu)
                }}
            }
        }
    }
}