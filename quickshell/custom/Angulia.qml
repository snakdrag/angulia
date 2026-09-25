import QtQuick
import qs.angulia.theme
import qs.angulia.quickshell.settings

Item {
    anchors.fill: parent
    property int direction: (1)

    readonly property bool isTop: ( direction === 0 || direction === 1 || direction === 2 )
    readonly property bool isLeft: ( direction === 0 || direction === 6 || direction === 7 )
    readonly property bool isRight: ( direction === 2 || direction === 3 || direction === 4 )
    readonly property bool isBottom: ( direction === 4 || direction === 5 || direction === 6 )

    readonly property bool isTopBottom: ( direction === 1 || direction === 5 || direction === 8)
    readonly property bool isLeftRight: ( direction === 3 || direction === 7 || direction === 8)

    readonly property bool isTopLeft: ( direction === 0 || direction === 1 || direction === 7 )
    readonly property bool isTopRight: ( direction === 1 || direction === 2 || direction === 3 )
    readonly property bool isBottomLeft: ( direction === 5 || direction === 6 || direction === 7 )
    readonly property bool isBottomRight: ( direction === 3 || direction === 4 || direction === 5 )

    property real radius: (Decorations.radius)
    property color color: (Colors.surface)
    property color textColor: (Colors.on_surface)
    property int edge: (Decorations.edge)
}