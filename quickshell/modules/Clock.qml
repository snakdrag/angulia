import QtQuick
import Quickshell
import "../angulia"
import "../../settings"

Angulia {
    id: _

    property var clock: (Settings.clock)
    readonly property var bar: (Settings.bar)
    direction: clock.direction

    implicitWidth: isVertical ? bar.width: clock.width
    implicitHeight: isVertical ? clock.height: bar.height

    DragHandler {
        onTranslationChanged: {
            let parentWidth = _.parent.width
            let parentHeight = _.parent.height

            let centerX = _.x + _.width / 2
            let centerY = _.y + _.height / 2

            if (parentWidth / 3 < centerX && centerX < parentWidth / 3 * 2) _.isVertical = false
            if (parentHeight / 3 < centerY && centerY < parentHeight / 3 * 2) _.isVertical = true
        }
        onActiveChanged: {
            let parentWidth = _.parent.width
            let parentHeight = _.parent.height

            let centerX = _.x + _.width / 2
            let centerY = _.y + _.height / 2

            let edgeX = Math.min(centerX, parentWidth - centerX)
            let edgeY = Math.min(centerY, parentHeight - centerY)
            if (_.x < _.edge) _.x = _.edge
            if (_.x + _.width > parentWidth - _.edge) _.x = parentWidth - _.width - _.edge
            if (_.y < _.edge) _.y = _.edge
            if (_.y + _.height > parentHeight - _.edge) _.y = parentHeight - _.height - _.edge

            if (centerX < edgeY && centerX < parentWidth / 2) _.x = _.edge
            if (parentWidth - centerX < edgeY && centerX > parentWidth / 2) _.x = parentWidth - _.width - _.edge
            if (centerY < edgeX && centerY < parentHeight / 2) _.y = _.edge
            if (parentHeight - centerY < edgeX && centerY > parentHeight / 2) _.y = parentHeight - _.height - _.edge
        }
    }

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(_clock.date, "hh:mm")
        color: _.textColor
        font: Settings.fonts.body
        SystemClock {
            id: _clock
            precision: SystemClock.Minutes
        }
    }
}
