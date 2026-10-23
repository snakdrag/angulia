import QtQuick
import Quickshell
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.polkit

    implicitWidth: this._data.width
    implicitHeight: bar.height

    show: PolkitAgent.isActive
    onShowChanged: {
        _field.text = ""
        _field.forceActiveFocus()
    }

    TextField {
        id: _field
        y: _._data.inputAtTop ? this.anchors.topMargin: Math.max(
            parent.height - this.height - this.anchors.bottomMargin,
            this.anchors.topMargin
        )
        anchors.left: parent.left
        anchors.right: parent.right
        height: _.bar.height - this.space * 2
        space: _.space
        color: _.textColor
        visible: _.show
        font: _._data.font
        background.radius: _.radius
        background.color: _.cardColor
        placeholderText: PolkitAgent.flow !== null ? PolkitAgent.flow.inputPrompt: ""
        echoMode: TextInput.Password
        verticalAlignment: TextInput.AlignVCenter
        Keys.onReturnPressed: PolkitAgent.submit(this.text)
        Keys.onEscapePressed: PolkitAgent.cancelAuthenticationRequest()
    }
    Rectangle {
        anchors.fill: parent
        anchors.margins: _.space
        anchors.topMargin: _._data.inputAtTop ? _field.height + _.space * 2: _.space
        anchors.bottomMargin: _._data.inputAtTop ? _.space: _field.height + _.space * 2
        radius: _.radius
        color: _.backgroundColor
        visible: _.show
    }
}
