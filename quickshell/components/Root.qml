import QtQuick
import Quickshell

ShellRoot {

    property list<var> modules: []
    Component.onCompleted: ExclusiveZones.modules = this.modules

    function check()
    {
        Qt.callLater(() => {
        let panels = []
        for (let i = 0; i < this.modules.length; i++)
        {
            let module = this.modules[i]
            if (module && module.roundcorners !== undefined)
            {
                panels.push(module)
                module.roundcorners.isTopLeft = false
                module.roundcorners.isTopRight = false
                module.roundcorners.isLeftTop = false
                module.roundcorners.isLeftBottom = false
                module.roundcorners.isRightTop = false
                module.roundcorners.isRightBottom = false
                module.roundcorners.isBottomLeft = false
                module.roundcorners.isBottomRight = false
            }
        }
        for (let i = 0; i < panels.length; i++) {
            for (let j = i + 1; j < panels.length; j++) {
                let a1 = panels[i]
                let a2 = panels[j]

                let a1XWidth = a1.x + a1.width
                let a1YHeight = a1.y + a1.height
                let a2XWidth = a2.x + a2.width
                let a2YHeight = a2.y + a2.height

                let a1w = a1.roundcorners.widthRadius + a2.roundcorners.finalRadius
                let a1h = a1.roundcorners.heightRadius + a2.roundcorners.finalRadius
                let a2w = a2.roundcorners.widthRadius + a1.roundcorners.finalRadius
                let a2h = a2.roundcorners.heightRadius + a1.roundcorners.finalRadius

                let a1_Top = a2.y + a1w <= a1.y && a1.y <= a2YHeight
                let a1_Left = a2.x + a1h <= a1.x && a1.x <= a2XWidth
                let a1_Right = a2.x <= a1XWidth && a1XWidth <= a2XWidth - a1h
                let a1_Bottom = a2.y <= a1YHeight && a1YHeight <= a2YHeight - a1w
                let a2_Top = a1.y + a2w <= a2.y && a2.y <= a1YHeight
                let a2_Left = a1.x + a2h <= a2.x && a2.x <= a1XWidth
                let a2_Right = a1.x <= a2XWidth && a2XWidth <= a1XWidth - a2h
                let a2_Bottom = a1.y <= a2YHeight && a2YHeight <= a1YHeight - a2w

                if (a1.y == a2YHeight)
                {
                    if (a1.x === a2.x)
                    {
                        a1.roundcorners.isTopLeft = true
                        a2.roundcorners.isBottomLeft = true
                    }
                    if (a1XWidth === a2XWidth)
                    {
                        a1.roundcorners.isTopRight = true
                        a2.roundcorners.isBottomRight = true
                    }
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftTop = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightTop = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftBottom = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightBottom = true
                }
                if (a1.x == a2XWidth)
                {
                    if (a1.y === a2.y)
                    {
                        a1.roundcorners.isLeftTop = true
                        a2.roundcorners.isRightTop = true
                    }
                    if (a1YHeight === a2YHeight)
                    {
                        a1.roundcorners.isLeftBottom = true
                        a2.roundcorners.isRightBottom = true
                    }
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopLeft = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomRight = true
                }
                if (a1XWidth == a2.x)
                {
                    if (a1.y === a2.y)
                    {
                        a1.roundcorners.isRightTop = true
                        a2.roundcorners.isLeftTop = true
                    }
                    if (a1YHeight === a2YHeight)
                    {
                        a1.roundcorners.isRightBottom = true
                        a2.roundcorners.isLeftBottom = true
                    }
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomRight = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomLeft = true
                }
                if (a1YHeight == a2.y)
                {
                    if (a1.x === a2.x)
                    {
                        a1.roundcorners.isBottomLeft = true
                        a2.roundcorners.isTopLeft = true
                    }
                    if (a1XWidth === a2XWidth)
                    {
                        a1.roundcorners.isBottomRight = true
                        a2.roundcorners.isTopRight = true
                    }
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftBottom = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightBottom = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftTop = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightTop = true
                }
            }
        }})
    }
}