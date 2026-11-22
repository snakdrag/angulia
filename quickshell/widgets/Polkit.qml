import QtQuick
import Quickshell
import "../components"
import "../states" as States

Item {

    property int space: (parent.space || 0)
    property int iconSize: (parent.iconSize || 0)
    property int inputHeight: (parent.inputHeight || 0)
    property color textColor: (parent.textColor || "#ffffff")
    property color cardColor: (parent.cardColor || "#888888")
    property bool inputAtTop: (parent.inputAtTop || false)
    property bool myMode: (parent.myMode || false)
    property font font: (parent.font || {family: "Inter", pixelSize: 12, bold: false, })
    readonly property int polkitHeight: (_field.height + _card.height + this.space)

    TextField {
        id: _field

        customY: _.inputAtTop ? 0: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: _.inputHeight

        color: _.textColor
        space: _.space

        echoMode: TextInput.Password
        enabled: !States.Polkit.inputLock
        font: _.font
        placeholderText: (
            States.Polkit.placeholderText !== "" ? States.Polkit.placeholderText:
            States.Polkit.flow === null ? "": States.Polkit.flow.inputPrompt
        )

        background.color: _.cardColor
        background.radius: _.radius

        Keys.onReturnPressed: { States.Polkit.submit(this.text); this.text = "" }
        Keys.onEscapePressed: States.Polkit.cancelAuthenticationRequest()
    }
    Card {
        id: _card

        customY: _.inputAtTop ? parent.height: 0
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: (
            this.myMode ? (this.image.visible ? this.image.height + this.space: 0) + this.textHeight:
            Math.max(this.image.height, this.textHeight)
        ) + this.space * 2

        color: _.cardColor
        radius: _.radius

        space: _.space
        myMode: _.myMode

        cover.color: _.textColor

        image.width: _.iconSize
        image.height: _.iconSize
        image.source: States.Polkit.flow === null ? "": Quickshell.iconPath(States.Polkit.flow.iconName, true)

        topText.font: _.font
        topText.text: States.Polkit.flow === null ? "": States.Polkit.flow.message
        topText.color: _.textColor
        topText.wrapMode: Text.WordWrap

        onClicked: States.Polkit.cancelAuthenticationRequest()
    }

    function call()
    {
        _field.forceActiveFocus()
        _field.text = ""
        States.Polkit.agent.lock = false
    }
}