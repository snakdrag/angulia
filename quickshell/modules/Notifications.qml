import "../components"
import "../widgets" as Widgets

Panel {

    implicitWidth: this.sets.width
    implicitHeight: _notifications.contentHeight + this.space * 2

    sets: Datas.settings.notifications
    show: _notifications.contentHeight > 0

    Widgets.Notifications {
        id: _notifications

        x: 0; y: 0
        anchors.fill: parent
        anchors.margins: parent.space
    }
}