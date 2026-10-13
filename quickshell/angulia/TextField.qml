import QtQuick

Rectangle {
    id: _
    property real inputRadius: (radius)
    color: "transparent"
    property color inputColor: ("#888888")
    property color textColor: ("#000000")
    property int space: (0)
    property font font: ({family: "Inter"})
    property string clearText: ("")
    property string searchText: ("")
    property int echoMode: (TextInput.Normal)

    property int verticalAlignment: (TextInput.AlignVCenter)
    property int horizontalAlignment: (TextInput.AlignHCenter)

    signal textChanged()
    signal upPressed()
    signal downPressed()
    signal leftPressed()
    signal rightPressed()
    signal escapePressed()
    signal returnPressed()

    function forceActiveFocus()
    {
        _search.forceActiveFocus()
    }
    MouseArea {
        anchors.fill: parent
        onClicked: _search.forceActiveFocus()
    }
    Rectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.inputRadius
        color: _.inputColor
        TextInput {
            id: _search
            anchors.fill: parent
            anchors.leftMargin: _.space
            anchors.rightMargin: _.space
            verticalAlignment: _.verticalAlignment
            horizontalAlignment: _.horizontalAlignment
            text: _.searchText
            font: _.font
            color: _.textColor
            clip: true
            focus: true
            enabled: true
            echoMode: _.echoMode
            onTextChanged: {_.searchText = this.text; _.textChanged()}
            Keys.onUpPressed: _.upPressed()
            Keys.onDownPressed: _.downPressed()
            Keys.onLeftPressed: _.leftPressed()
            Keys.onRightPressed: _.rightPressed()
            Keys.onEscapePressed: _.escapePressed()
            Keys.onReturnPressed: _.returnPressed()
            Text {
                anchors.fill: parent
                verticalAlignment: _.verticalAlignment
                horizontalAlignment: _.horizontalAlignment
                text: _.clearText
                font: _.font
                color: _.textColor
                opacity: 0.5
                visible: _search.text === ""
            }
        }
    }
}