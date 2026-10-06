import QtQuick

QtObject {
    property int direction: (0)

    readonly property bool isTop: (direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 2)
    readonly property bool isLeft: (direction % 9 === 0 || direction % 9 === 6 || direction % 9 === 7)
    readonly property bool isRight: (direction % 9 === 2 || direction % 9 === 3 || direction % 9 === 4)
    readonly property bool isBottom: (direction % 9 === 4 || direction % 9 === 5 || direction % 9 === 6)
    readonly property bool isTopBottom: (direction % 9 === 1 || direction % 9 === 5 || direction % 9 === 8)
    readonly property bool isLeftRight: (direction % 9 === 3 || direction % 9 === 7 || direction % 9 === 8)

    readonly property bool notTop: (isLeftRight || isBottom)
    readonly property bool notLeft: (isTopBottom || isRight)
    readonly property bool notRight: (isLeft || isTopBottom)
    readonly property bool notBottom: (isTop || isLeftRight)
    readonly property bool notTopBottom: (isLeft || isRight)
    readonly property bool notLeftRight: (isTop || isBottom)
}