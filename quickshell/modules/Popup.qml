import "../components"
import "../states" as States
import "../widgets" as Widgets

Panel {

    customX: States.Popup.customX
    customY: States.Popup.customY
    z: 1
    implicitWidth: sets.width
    implicitHeight: _popup.contentHeight + this.space * 2

    exclusiveZoneIgnore: false
    sets: Datas.settings.popup
    show: States.Popup.open && _popup.contentHeight > 0

    Widgets.Popup {
        id: _popup

        x: 0; y: 0
        anchors.fill: parent
        anchors.margins: parent.space
    }
}
