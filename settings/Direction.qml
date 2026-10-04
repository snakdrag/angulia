import QtQuick

Item {
    id: _

    property int direction: (1)

    readonly property bool _IsTop: ( direction % 9 === 0 || direction % 9 === 1 || direction % 9 === 2 )
    readonly property bool _IsLeft: ( direction % 9 === 0 || direction % 9 === 6 || direction % 9 === 7 )
    readonly property bool _IsRight: ( direction % 9 === 2 || direction % 9 === 3 || direction % 9 === 4 )
    readonly property bool _IsBottom: ( direction % 9 === 4 || direction % 9 === 5 || direction % 9 === 6 )
}