import QtQuick
import Quickshell
import Quickshell.Wayland
import "angulia"
import "services"
import "../settings"

ShellRoot {
    id: _
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
            TextField {
                x: parent.width / 2 - width / 2
                y: parent.height - height - Settings.edge
                echoMode: TextInput.Password
                implicitWidth: 300
                implicitHeight: Settings.bar.height
                space: Settings.space
                radius: Settings.radius
                color: Settings.colors.surface
                textColor: Settings.colors.on_surface
                inputColor: Settings.colors.surface_container
                horizontalAlignment: TextInput.AlignHCenter
                onReturnPressed: LockScreen.authenticate(this.searchText)
            }
        }
    }
}