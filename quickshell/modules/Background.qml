import QtQuick
import "../components"

Rectangle {
    id: _

    property string wallpaper: (Datas.colors.image)

    z: -2
    anchors.fill: parent
    color: "#000000"

    onWallpaperChanged: {
        if (wallpaper === _image.source.toString())
            return

        _switch.stop()
        _switch.start()
    }

    Image {
        id: _image

        anchors.fill: parent
        sourceSize.width: this.width
        sourceSize.height: this.height

        asynchronous: true
        cache: true
        fillMode: Image.PreserveAspectCrop
        source: _.wallpaper
    }

    SequentialAnimation {
        id: _switch

        NumberAnimation {
            target: _image
            property: "opacity"
            duration: 300
            to: 0
            easing.type: Easing.InOutQuad
        }

        ScriptAction {
            script: _image.source = _.wallpaper
        }

        NumberAnimation {
            target: _image
            property: "opacity"
            duration: 300
            to: 1
            easing.type: Easing.InOutQuad
        }
    }
}