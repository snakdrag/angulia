import QtQuick
import Quickshell
import "../states"
import "../components"

Panel {

    anchors.margins: 5
    customX: parent.width / 2
    customY: parent.height

    implicitWidth: 300
    implicitHeight: _field.height + this.space * 2 + (_card.height === 0 ? 0: _card.height + this.space)

    radius: 12

    property int space: (10)
    property color textColor: ("#ffffff")
    property color cardColor: ("#222222")
    property bool inputAtTop: (false)
    property int iconSize: (40)
    property int inputHeight: (30)
    property font font: ({
        family: "JetBrainMono",
        pixelSize: 15
    })

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
                Polkit.flow !== null ? Polkit.flow.inputPrompt: ""
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

        topText.text: Polkit.flow !== null ? Polkit.flow.message: ""
        topText.font.family: parent.font.family
        topText.font.pixelSize: parent.font.pixelSize
        topText.color: parent.textColor
        topText.wrapMode: Text.WordWrap

        color: parent.cardColor
        radius: parent.radius
        space: parent.space

        item.customY: this.height / 2
        item.anchors.leftMargin: this.image.visible ? this.image.width + this.space * 2: this.space
        implicitHeight: Math.max(parent.iconSize, this.textHeight) + this.space * 2

        image.customY: this.height / 2
        image.anchors.margins: this.space
        image.width: parent.iconSize
        image.height: parent.iconSize
        image.source: Polkit.flow !== null ? Quickshell.iconPath(Polkit.flow.iconName, true): ""

        onClicked: Polkit.cancelAuthenticationRequest()
    }
}