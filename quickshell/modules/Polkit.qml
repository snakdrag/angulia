import QtQuick
import Quickshell
import "../states"
import "../components"

Panel {

    customX: parent.width / 2
    customY: parent.height

    implicitWidth: 300
    implicitHeight: _field.height + this.space * 2 + (_card.height === 0 ? 0: _card.height + this.space)

    property bool inputAtTop: (false)
    property int iconSize: (40)
    property int inputHeight: (30)
    property bool myMode: (false)
    font.bold: true

    show: Polkit.agent.isActive
    onShowChanged: {
        if (this.show)
        {
            Polkit.agent.lock = false;
            _field.text = "";
            _field.forceActiveFocus()
        }
    }

    TextField {
        id: _field
        customY: parent.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.inputHeight
        space: parent.space

        background.color: parent.cardColor
        background.radius: parent.radius

        enabled: !Polkit.inputLock

        color: parent.textColor
        echoMode: TextInput.Password
        placeholderText: (
            Polkit.placeholderText === "" ?
            (
                Polkit.flow === null ? "": Polkit.flow.inputPrompt
            ):
            Polkit.placeholderText
        )

        Keys.onReturnPressed: { Polkit.submit(this.text); this.text = "" }
        Keys.onEscapePressed: Polkit.cancelAuthenticationRequest()
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
        topText.text: Polkit.flow === null ? "": Polkit.flow.message
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap

        color: parent.cardColor
        radius: parent.radius
        space: parent.space

        implicitHeight: (
            this.myMode ?
            (this.image.visible ? this.image.height + this.space: 0) + this.textHeight + this.space * 2:
            Math.max(this.image.height, this.textHeight) + this.space * 2
        )

        image.width: parent.iconSize
        image.height: parent.iconSize
        image.source: Polkit.flow === null ? "": Quickshell.iconPath(Polkit.flow.iconName, true)

        onClicked: Polkit.cancelAuthenticationRequest()
    }
}