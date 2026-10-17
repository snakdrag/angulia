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
        Angulia {
            customX: parent.width / 2
            customY: parent.height
            implicitWidth: 200
            implicitHeight: this.bar.height
            TextField {
                anchors.fill: parent

                radius: parent.radius
                space: parent.space

                color: parent.textColor
                backgroundColor: parent.cardColor

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