import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {

    implicitWidth: this.sets.width
    implicitHeight: _field.height + _card.height + this.space * 3

    sets: Datas.settings.polkit
    show: States.Polkit.open
    onShowChanged: { if (this.show) _field.forceActiveFocus(); _field.text = ""; States.Polkit.agent.lock = false }

    TextField {
        id: _field

        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight

        color: parent.textColor
        space: parent.space

        echoMode: TextInput.Password
        enabled: !States.Polkit.inputLock
        font.family: parent.font.family
        font.pixelSize: parent.font.pixelSize
        font.bold: parent.font.bold
        placeholderText: (
            States.Polkit.placeholderText === "" ?
            (States.Polkit.flow === null ? "": States.Polkit.flow.inputPrompt):
            States.Polkit.placeholderText
        )

        background.color: parent.cardColor
        background.radius: parent.radius

        Keys.onReturnPressed: { States.Polkit.submit(this.text); this.text = "" }
        Keys.onEscapePressed: States.Polkit.cancelAuthenticationRequest()
    }
    Card {
        id: _card

        customY: parent.inputAtTop ? parent.height: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: this.space
        implicitHeight: (
            this.myMode ? (this.image.visible ? this.image.height + this.space: 0) + this.textHeight:
            Math.max(this.image.height, this.textHeight)
        ) + this.space * 2

        color: parent.cardColor
        radius: parent.radius

        space: parent.space
        myMode: parent.myMode

        cover.color: parent.textColor

        image.width: parent.iconSize
        image.height: parent.iconSize
        image.source: States.Polkit.flow === null ? "": Quickshell.iconPath(States.Polkit.flow.iconName, true)

        topText.font.family: parent.font.family
        topText.font.pixelSize: parent.font.pixelSize
        topText.font.bold: parent.font.bold
        topText.text: States.Polkit.flow === null ? "": States.Polkit.flow.message
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap

        onClicked: States.Polkit.cancelAuthenticationRequest()
    }
}