import "../components"
import "../states" as States
import "../widgets" as Widgets

Panel {
    id: _

    implicitWidth: this.sets.width
    implicitHeight: _polkit.polkitHeight + this.space * 2

    sets: Datas.settings.polkit
    show: States.Polkit.open

    onShowChanged: if (this.show) _polkit.call()

    Widgets.Polkit {
        id: _polkit

        x: 0; y: 0
        anchors.fill: parent
        anchors.margins: parent.space
    }
}