import QtQuick
import Quickshell
import "../components"
import "../states" as States

ClippingRectangle {
    id: _

    property int space: (parent.space || 0)
    property int iconSize: (parent.iconSize || 0)
    property color textColor: (parent.textColor || "#ffffff")
    property color cardColor: (parent.cardColor || "#888888")
    property bool myMode: (parent.myMode || false)
    property font font: (parent.font || {family: "Inter", pixelSize: 12, bold: false, })
    readonly property int contentHeight: (_list.contentHeight)

    color: "transparent"
    radius: parent.radius

    List {
        id: _list

        spacing: _.space

        model: ScriptModel { values: States.Notifications.trackedNotifications.values }
        delegate: Item {
            id: _card

            required property var modelData
            readonly property bool haveAction: (this.modelData.actions.length > 0)

            implicitWidth: _main.width
            implicitHeight: _main.height

            Button {

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                implicitWidth: Math.min(parent.width, Math.max(_main.x - _.space, parent.width / 4))

                color: _.cardColor
                radius: _.radius
                active: (
                    this.hovered && _main.x - _.space >= parent.width / 4 ||
                    _main.x - _.space > parent.width / 2
                )
                visible: _main.x > 0

                cover.color: _.textColor

                onClicked: parent.act()

                Text {

                    anchors.centerIn: parent

                    color: _.textColor
                    opacity: (_main.x - _.space - _card.width / 8) / _card.width * 8

                    font.family: _.font.family
                    font.pixelSize: _.font.pixelSize
                    font.bold: false

                    text: _card.haveAction ? "Open": "Clear"
                }
            }
            Button {

                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                implicitWidth: Math.min(parent.width, Math.max(-_main.x - _.space, parent.width / 4))

                color: _.cardColor
                radius: _.radius
                active: (
                    this.hovered && -_main.x - _.space >= parent.width / 4 ||
                    -_main.x - _.space > parent.width / 2
                )
                visible: _main.x < 0

                cover.color: _.textColor

                onClicked: parent.modelData.dismiss()

                Text {

                    anchors.centerIn: parent

                    color: _.textColor
                    opacity: (-_main.x - _.space - _card.width / 8) / _card.width * 8

                    font.family: _.font.family
                    font.pixelSize: _.font.pixelSize
                    font.bold: false
                    text: "Clear"
                }
            }
            Card {
                id: _main

                implicitWidth: _.width
                implicitHeight: (
                    this.myMode ?
                    (this.image.visible ? this.image.height + this.space: 0) + this.textHeight + this.space * 2:
                    Math.max(this.image.height, this.textHeight) + this.space * 2
                )

                color: _.cardColor
                radius: _.radius

                myMode: _.myMode
                space: _.space

                cover.color: _.textColor

                image.width: _.iconSize
                image.height: _.iconSize
                image.source: parent.modelData.image || Quickshell.iconPath(parent.modelData.appIcon, true)

                mouseArea.cursorShape: Qt.ArrowCursor

                topText.font.family: _.font.family
                topText.font.pixelSize: _.font.pixelSize
                topText.font.bold: true
                topText.text: parent.modelData.summary
                topText.color: _.textColor
                topText.maximumLineCount: parent.modelData.urgency === States.Notifications.urgency.critical ? 0: 2

                bottomText.font: _.font
                bottomText.text: parent.modelData.body
                bottomText.color: _.textColor
                bottomText.maximumLineCount: parent.modelData.urgency === States.Notifications.urgency.critical ? 0: 4

                onLeftClicked: this.x = this.width / 4 + this.space
                onRightClicked: this.x = -this.width / 4 - this.space
                onMiddleClicked: this.x = 0

                DragHandler {

                    xAxis.enabled: true
                    yAxis.enabled: false
                    onActiveChanged: {
                        if (parent.x < -parent.width / 2 - parent.space) _card.modelData.dismiss();
                        if (parent.x < -parent.width / 4 - parent.space) parent.x = -parent.width / 4 - parent.space;
                        if (parent.x > parent.width / 2 + parent.space) _card.act();
                        if (parent.x > parent.width / 4 + parent.space) parent.x = parent.width / 4 + parent.space;
                        if (parent.x > -parent.width / 4 && parent.x < parent.width / 4) parent.x = 0;
                    }
                }
            }

            function act()
            {
                if (this.haveAction) this.modelData.actions[0].invoke();
                this.modelData.dismiss();
            }
        }
    }

}