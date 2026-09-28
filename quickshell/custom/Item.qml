import QtQuick

Item {
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

    property color color

    Behavior on color {
        ColorAnimation {
            duration: 1000
            easing.type: Easing.OutCubic
        }
    }
}