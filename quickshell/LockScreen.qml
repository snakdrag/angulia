import QtQuick
import Quickshell
import Quickshell.Wayland
import "angulia"
import "states"
import "../settings"

ShellRoot {
    id: _
    WlSessionLock {
        id: _lock
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
                implicitHeight: bar.height
                TextField {
                    anchors.fill: parent
                    echoMode: TextInput.Password
                    space: parent.space
                    color: parent.textColor
                    backgroundColor: parent.cardColor
                    enabled: !LockScreen.inputLock
                    radius: parent.radius
                    placeholderText: LockScreen.placeholderText
                    verticalAlignment: TextInput.AlignVCenter
                    onTextChanged: LockScreen.placeholderText = ""
                    Keys.onReturnPressed: {LockScreen.authenticate(this.text); this.text = ""}
                }
            }
        }
    }
}