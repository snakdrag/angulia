import QtQuick
import "../components"

Rectangle {
    anchors.fill: parent
    color: "#000000"
    property string wallpaper: (Datas.colors.image)
    Image {
        anchors.fill: parent
        source: parent.wallpaper
        fillMode: Image.PreserveAspectCrop
    }
}
