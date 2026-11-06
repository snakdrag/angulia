import QtQuick
import "../components"

Image {
    property string wallpaper: (Datas.colors.image)

    anchors.fill: parent
    source: this.wallpaper
    fillMode: Image.PreserveAspectCrop
}