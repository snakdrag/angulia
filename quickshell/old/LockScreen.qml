import QtQuick
import Quickshell.Wayland
import "../states"
import "../angulia"
import "../../settings"

WlSessionLock {
    locked: LockScreen.open
    WlSessionLockSurface {
        Image {
            anchors.fill: parent
            source: Settings.colors.image
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            fillMode: Image.PreserveAspectCrop
        }
        Clock {
            customX: parent.width / 2
            customY: parent.height / 4
            show: false
            opacity: 0.6
        }
        Angulia {
            customX: parent.width / 2
            customY: parent.height
            implicitWidth: parent.width / 6
            implicitHeight: this.bar.height
            TextField {
                anchors.fill: parent

                background.radius: parent.radius
                space: parent.space

                color: parent.textColor
                background.color: parent.cardColor

                echoMode: TextInput.Password
                verticalAlignment: TextInput.AlignVCenter

                enabled: !LockScreen.inputLock
                placeholderText: LockScreen.placeholderText
                onTextChanged: LockScreen.placeholderText = ""
                Keys.onReturnPressed: {LockScreen.authenticate(this.text); this.text = ""}
            }
        }
    }
}