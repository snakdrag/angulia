import QtQuick
import Quickshell
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.polkit

    implicitWidth: this._data.width
    implicitHeight: bar.height + _card.textHeight + this.space * 3 + (
        this.isVertical || !_card.image.visible ?
        0:
        this.imageHeight + this.space
    )

    show: PolkitAgent.isActive
    onShowChanged: if (this.show) {_field.text = ""; _field.forceActiveFocus()}

    TextField {
        id: _field
        y: _._data.inputAtTop ? this.anchors.topMargin: Math.max(
            parent.height - this.height - this.anchors.bottomMargin,
            this.anchors.topMargin
        )
        anchors.left: parent.left
        anchors.right: parent.right
        height: _.bar.height - this.space * 2
        space: _.space
        color: _.textColor
        visible: _.show
        enabled: !PolkitAgent.inputLock
        font: _._data.font
        background.radius: _.radius
        background.color: _.cardColor
        placeholderText: (
            PolkitAgent.placeholderText === "" ?
            (
                PolkitAgent.flow !== null ? PolkitAgent.flow.inputPrompt: ""
            ):
            PolkitAgent.placeholderText
        )
        echoMode: TextInput.Password
        verticalAlignment: TextInput.AlignVCenter
        Keys.onReturnPressed: {PolkitAgent.submit(this.text); this.text = ""}
        Keys.onEscapePressed: PolkitAgent.cancelAuthenticationRequest()
    }
    Card {
        id: _card
        anchors.fill: parent
        anchors.margins: _.space
        anchors.topMargin: _._data.inputAtTop ? _field.height + _.space * 2: _.space
        anchors.bottomMargin: _._data.inputAtTop ? _.space: _field.height + _.space * 2
        radius: _.radius
        color: _.cardColor
        visible: _.show
        activeColor: _.textColor
        space: _.space
        isVertical: _.isVertical
        imageWidth: _.imageWidth
        imageHeight: _.imageHeight
        imageSource: PolkitAgent.flow !== null ? Quickshell.iconPath(PolkitAgent.flow.iconName, true): ""
        wrapMode: Text.WordWrap
        topText: PolkitAgent.flow !== null ? PolkitAgent.flow.message: ""
        topFont: _._data.font
    }
}
