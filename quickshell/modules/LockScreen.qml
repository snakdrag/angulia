import QtQuick
import Quickshell.Wayland
import "../components"
import "../states" as States

WlSessionLock {
    id: _

    locked: States.LockScreen.open

    WlSessionLockSurface {

        Background {}
        Clock {

            customX: parent.width / 2
            customY: parent.height / 4

            opacity: 0.8
            show: false

            font.family: "Inter"
            font.pixelSize: 120
            font.bold: true
        }
        Panel {

            customX: parent.width / 2
            customY: parent.height
            implicitWidth: parent.width / 6
            implicitHeight: 50

            exclusiveZoneIgnore: true

            TextField {

                anchors.fill: parent

                space: parent.space

                color: parent.textColor

                enabled: !States.LockScreen.inputLock
                echoMode: TextInput.Password
                font.family: parent.font.family
                font.pixelSize: parent.font.pixelSize
                font.bold: parent.font.bold
                placeholderText: States.LockScreen.placeholderText

                background.color: parent.cardColor
                background.radius: parent.radius

                onTextChanged: States.LockScreen.placeholderText = ""
                Keys.onReturnPressed: {States.LockScreen.authenticate(this.text); this.text = ""}
                Keys.onEscapePressed: this.text = ""
            }
        }
    }
}