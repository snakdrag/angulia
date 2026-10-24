import QtQuick

CustomRectangle {

    property bool hovered: (false)
    property bool active: (this.hovered)
    property Rectangle cover: (_rectangle)
    property MouseArea mouseArea: (_mouseArea)

    signal clicked()
    signal leftClicked()
    signal rightClicked()
    signal middleClicked()
    onLeftClicked: this.clicked()
    onRightClicked: this.clicked()
    onMiddleClicked: this.clicked()

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: parent.hovered = true
        onExited: parent.hovered = false
        onClicked: mouse => {
        if (mouse.button === Qt.LeftButton)
        {
            parent.leftClicked()
        }
        if (mouse.button === Qt.RightButton)
        {
            parent.rightClicked()
        }
        if (mouse.button === Qt.MiddleButton)
        {
            parent.middleClicked()
        }}
    }

    CustomRectangle {
        id: _rectangle
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: parent.active ? 0.1: 0
        Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
        z: 1
    }
}
// cursorShapes

// Qt.ArrowCursor
// Qt.UpArrowCursor
// Qt.CrossCursor
// Qt.WaitCursor
// Qt.IBeamCursor
// Qt.SizeVerCursor
// Qt.SizeHorCursor
// Qt.SizeBDiagCursor
// Qt.SizeFDiagCursor
// Qt.SizeAllCursor
// Qt.BlankCursor
// Qt.SplitVCursor
// Qt.SplitHCursor
// Qt.PointingHandCursor
// Qt.ForbiddenCursor
// Qt.WhatsThisCursor
// Qt.BusyCursor
// Qt.OpenHandCursor
// Qt.ClosedHandCursor
// Qt.DragCopyCursor
// Qt.DragMoveCursor
// Qt.DragLinkCursor