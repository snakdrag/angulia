import QtQuick

Item {
    id: _

    property int direction: (1)

    readonly property bool _IsTop: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 2 )
    readonly property bool _IsLeft: ( direction % 9 === 0 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsRight: ( direction % 9 === 2 || direction % 9 === 3 || direction % 9 === 4 )
    readonly property bool _IsBottom: ( direction % 9 === 4 || direction % 9 === 5 || direction % 9 === 6 )

    readonly property bool _IsTopBottom: ( direction % 9 === 1 || direction % 9 === 5 || direction % 9 === 8)
    readonly property bool _IsLeftRight: ( direction % 9 === 3 || direction % 9 === 7 || direction % 9 === 8)

    readonly property bool _IsTopLeft: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 7 )
    readonly property bool _IsTopRight: ( direction % 9 === 1 || direction % 9 === 2 || direction % 9 === 3 )
    readonly property bool _IsBottomLeft: ( direction % 9 === 5 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsBottomRight: ( direction % 9 === 3 || direction % 9 === 4 || direction % 9 === 5 )
}