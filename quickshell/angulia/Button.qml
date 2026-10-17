import QtQuick

Rectangle {

    property bool active: (false)
    property color activeColor: ("#000000")
    property MouseArea mouseArea: (_mouseArea)

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }

    Rectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        opacity: parent.active ? 0.1: 0
        color: parent.activeColor
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