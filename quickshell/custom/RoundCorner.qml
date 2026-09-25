import QtQuick
import QtQuick.Shapes

Item {
    id: _

    property real radius: (0)
    property color color: ("#ffffff")

    implicitWidth: radius
    implicitHeight: radius
    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            fillColor: _.color
            strokeColor: "transparent"
            startX: _.radius
            startY: 0
            PathLine {
                x: 0
                y: 0
            }
            PathLine {
                x: 0
                y: _.radius
            }
            PathArc {
                x: _.radius
                y: 0
                radiusX: _.radius
                radiusY: _.radius
            }
        }
    }
}