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
                implicitWidth: 300
                implicitHeight: bar.height
                TextField {
                    anchors.fill: parent
                    echoMode: TextInput.Password
                    space: parent.space
                    color: parent.textColor
                    backgroundColor: parent.cardColor
                    radius: parent.radius
                    verticalAlignment: TextInput.AlignVCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    Keys.onReturnPressed: {LockScreen.authenticate(this.text); this.text = ""}
                }
            }
        }
    }
}