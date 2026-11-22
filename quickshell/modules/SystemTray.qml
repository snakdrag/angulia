import "../components"
import "../widgets" as Widgets

Panel {
    id: _

    implicitWidth: Math.max(_systemtray.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: Math.max(_systemtray.contentHeight, this.cardHeight) + this.space * 2

    exclusiveZoneIgnore: true
    sets: Datas.settings.systemtray
    show: _systemtray.contentWidth > 0 || _systemtray.contentHeight > 0

    Widgets.SystemTray {
        id: _systemtray

        x: 0; y: 0
        anchors.fill: parent
        anchors.margins: parent.space
    }
}