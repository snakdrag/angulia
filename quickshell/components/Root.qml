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

                // module.roundcorners.topLeftRadius = module.radius
                // module.roundcorners.topRightRadius = module.radius
                // module.roundcorners.leftTopRadius = module.radius
                // module.roundcorners.leftBottomRadius = module.radius
                // module.roundcorners.rightTopRadius = module.radius
                // module.roundcorners.rightBottomRadius = module.radius
                // module.roundcorners.bottomLeftRadius = module.radius
                // module.roundcorners.bottomRightRadius = module.radius

                // module.topLeftRadius = module.radius
                // module.topRightRadius = module.radius
                // module.bottomLeftRadius = module.radius
                // module.bottomRightRadius = module.radius
            }
        }
        for (let i = 0; i < panels.length; i++)
        {
            for (let j = i + 1; j < panels.length; j++)
            {
                let a1 = panels[i]
                let a2 = panels[j]

                let a1XWidth = a1.x + a1.width
                let a1YHeight = a1.y + a1.height
                let a2XWidth = a2.x + a2.width
                let a2YHeight = a2.y + a2.height

                let a1_Top = a2.y <= a1.y && a1.y <= a2YHeight
                let a1_Left = a2.x <= a1.x && a1.x <= a2XWidth
                let a1_Right = a2.x <= a1XWidth && a1XWidth <= a2XWidth
                let a1_Bottom = a2.y <= a1YHeight && a1YHeight <= a2YHeight
                let a2_Top = a1.y <= a2.y && a2.y <= a1YHeight
                let a2_Left = a1.x <= a2.x && a2.x <= a1XWidth
                let a2_Right = a1.x <= a2XWidth && a2XWidth <= a1XWidth
                let a2_Bottom = a1.y <= a2YHeight && a2YHeight <= a1YHeight

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
                    if (a1_Left && !a2_Left)
                    {
                        a1.roundcorners.isLeftTop = true
                    }
                    if (a2_Left && !a1_Left)
                    {
                        a2.roundcorners.isLeftBottom = true
                    }
                    if (a1_Right && !a2_Right)
                    {
                        a1.roundcorners.isRightTop = true
                    }
                    if (a2_Right && !a1_Right)
                    {
                        a2.roundcorners.isRightBottom = true
                    }
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
                    if (a1_Top && !a2_Top)
                    {
                        a1.roundcorners.isTopLeft = true
                    }
                    if (a2_Top && !a1_Top)
                    {
                        a2.roundcorners.isTopRight = true
                    }
                    if (a1_Bottom && !a2_Bottom)
                    {
                        a1.roundcorners.isBottomLeft = true
                    }
                    if (a2_Bottom && !a1_Bottom)
                    {
                        a2.roundcorners.isBottomRight = true
                    }
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
                    if (a1_Top && !a2_Top)
                    {
                        a1.roundcorners.isTopRight = true
                    }
                    if (a1_Bottom && !a2_Bottom)
                    {
                        a1.roundcorners.isBottomRight = true
                    }
                    if (a2_Top && !a1_Top)
                    {
                        a2.roundcorners.isTopLeft = true
                    }
                    if (a2_Bottom && !a1_Bottom)
                    {
                        a2.roundcorners.isBottomLeft = true
                    }
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
                    if (a1_Left && !a2_Left)
                    {
                        a1.roundcorners.isLeftBottom = true
                    }
                    if (a1_Right && !a2_Right)
                    {
                        a1.roundcorners.isRightBottom = true
                    }
                    if (a2_Left && !a1_Left)
                    {
                        a2.roundcorners.isLeftTop = true
                    }
                    if (a2_Right && !a1_Right)
                    {
                        a2.roundcorners.isRightTop = true
                    }
                }
            }
        }})
    }
}