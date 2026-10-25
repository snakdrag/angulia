import QtQuick

CustomRectangle {

    property bool hovered: (false)
    property bool active: (this.hovered)
    readonly property CustomRectangle cover: (_rectangle)
    readonly property MouseArea mouseArea: (_mouseArea)

    signal clicked()
    signal leftClicked()
    signal rightClicked()
    signal middleClicked()

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: parent.hovered = true
        onExited: parent.hovered = false
        onClicked: mouse => {
        if (mouse.button === Qt.LeftButton) parent.leftClicked();
        if (mouse.button === Qt.RightButton) parent.rightClicked();
        if (mouse.button === Qt.MiddleButton) parent.middleClicked();
        parent.clicked()}
    }

    CustomRectangle {
        id: _rectangle
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: parent.active ? 0.1: 0
        z: 1
    }
}