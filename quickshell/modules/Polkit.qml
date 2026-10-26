import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {

    sets: Datas.settings.polkit

    implicitWidth: this.sets.width
    implicitHeight: _field.height + this.space * 2 + (_card.height === 0 ? 0: _card.height + this.space)

    show: States.Polkit.open
    onShowChanged: {
        if (this.show) _field.forceActiveFocus();
        _field.text = "";
        States.Polkit.agent.lock = false;
    }

    TextField {
        id: _field
        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight
        space: parent.space

        font.family: parent.font.family
        font.pixelSize: parent.font.pixelSize
        font.bold: parent.font.bold

        background.color: parent.cardColor
        background.radius: parent.radius

        enabled: !States.Polkit.inputLock

        color: parent.textColor
        echoMode: TextInput.Password
        placeholderText: States.Polkit.placeholderText === "" ? (States.Polkit.flow === null ? "": States.Polkit.flow.inputPrompt): States.Polkit.placeholderText

        Keys.onReturnPressed: { States.Polkit.submit(this.text); this.text = "" }
        Keys.onEscapePressed: States.Polkit.cancelAuthenticationRequest()
        visible: parent.show
    }
    Card {
        id: _card
        customY: parent.inputAtTop ? parent.height: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: this.space

        myMode: parent.myMode

        cover.color: parent.textColor

        topText.font.family: parent.font.family
        topText.font.pixelSize: parent.font.pixelSize
        topText.font.bold: parent.font.bold
        topText.text: States.Polkit.flow === null ? "": States.Polkit.flow.message
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap

        color: parent.cardColor
        radius: parent.radius
        space: parent.space

        implicitHeight: (
            this.myMode ?
            (this.image.visible ? this.image.height + this.space: 0) + this.textHeight:
            Math.max(this.image.height, this.textHeight)
        ) + this.space * 2

        image.width: parent.iconSize
        image.height: parent.iconSize
        image.source: States.Polkit.flow === null ? "": Quickshell.iconPath(States.Polkit.flow.iconName, true)

        onClicked: States.Polkit.cancelAuthenticationRequest()
        visible: parent.show
    }
}