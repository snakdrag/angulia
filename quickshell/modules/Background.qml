import QtQuick
import "../components"

Rectangle {

    property string wallpaper: (Datas.colors.image)

    anchors.fill: parent

    color: "#000000"

    Image {

        anchors.fill: parent

        source: parent.wallpaper
        fillMode: Image.PreserveAspectCrop
    }
}
