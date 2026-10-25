import QtQuick
import Quickshell.Wayland
import "../components"
import "../states"

WlSessionLock {
    id: _
    locked: LockScreen.open
    property string wallpaper: (Datas.colors.image)
    property font font: ({
        family: "Inter",
        pixelSize: 120,
        bold: true
    })
    WlSessionLockSurface {
        color: "#000000"
        CustomImage {
            anchors.fill: parent
            source: _.wallpaper
            fillMode: Image.PreserveAspectCrop
        }
        Clock {
            customX: parent.width / 2
            customY: parent.height / 4
            show: false
            opacity: 0.8
            font.family: _.font.family
            font.pixelSize: _.font.pixelSize
            font.bold: _.font.bold
        }
        Panel {
            customX: parent.width / 2
            customY: parent.height
            implicitWidth: parent.width / 6
            implicitHeight: 50
            TextField {
                anchors.fill: parent

                space: parent.space

                font.family: parent.font.family
                font.pixelSize: parent.font.pixelSize
                font.bold: parent.font.bold

                background.color: parent.cardColor
                background.radius: parent.radius

                enabled: !LockScreen.inputLock

                color: parent.textColor
                echoMode: TextInput.Password

                placeholderText: LockScreen.placeholderText
                onTextChanged: LockScreen.placeholderText = ""

                Keys.onReturnPressed: {LockScreen.authenticate(this.text); this.text = ""}
                Keys.onEscapePressed: this.text = ""
            }
        }
    }
}