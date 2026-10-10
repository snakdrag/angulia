import QtQuick
import Quickshell
import "../angulia"
import "../../settings"
import "../modules" as Modules

Layer {
    id: _top
    layer: layers.Bottom
    Component.onCompleted: anguliaCheck()
    function anguliaCheck()
    {
        let angulia = [];
        for (let i = 0; i < _container.children.length; i++) {
            let child = _container.children[i];
            if (child._itemName === "Angulia")
            {
                angulia.push(child);
                child.isTopLeft = false;
                child.isTopRight = false;
                child.isLeftTop = false;
                child.isLeftBottom = false;
                child.isRightTop = false;
                child.isRightBottom = false;
                child.isBottomLeft = false;
                child.isBottomRight = false;
            }
        }
        for (let i = 0; i < angulia.length; i++) {
            for (let j = i + 1; j < angulia.length; j++) {
                let r1 = angulia[i];
                let r2 = angulia[j];

                let r1_Top = (
                    r2.y - r1.y <= Settings.radius &&
                    r1.y - (r2.y + r2.height) <= Settings.radius
                );
                let r1_Left = (
                    r2.x - r1.x <= Settings.radius &&
                    r1.x - (r2.x + r2.width) <= Settings.radius
                );
                let r1_Right = (
                    r2.x - (r1.x + r1.width) <= Settings.radius &&
                    (r1.x + r1.width) - (r2.x + r2.width) <= Settings.radius
                );
                let r1_Bottom = (
                    r2.y - (r1.y + r1.height) <= Settings.radius &&
                    (r1.y + r1.height) - (r2.y + r2.height) <= Settings.radius
                );
                let r2_Top = (
                    r1.y - r2.y <= Settings.radius &&
                    r2.y - (r1.y + r1.height) <= Settings.radius
                );
                let r2_Left = (
                    r1.x - r2.x <= Settings.radius &&
                    r2.x - (r1.x + r1.width) <= Settings.radius
                );
                let r2_Right = (
                    r1.x - (r2.x + r2.width) <= Settings.radius &&
                    (r2.x + r2.width) - (r1.x + r1.width) <= Settings.radius
                );
                let r2_Bottom = (
                    r1.y - (r2.y + r2.height) <= Settings.radius &&
                    (r2.y + r2.height) - (r1.y + r1.height) <= Settings.radius
                );

                if (-Settings.radius <= (r1.y - (r2.y + r2.height)) && (r1.y - (r2.y + r2.height)) <= 0)
                {
                    if (r1_Left) r1.isTopLeft = true;
                    if (r1_Right) r1.isTopRight = true;
                    if (r2_Left) r2.isBottomLeft = true;
                    if (r2_Right) r2.isBottomRight = true;
                    if (r1_Left && !r2_Left) r1.isLeftTop = true;
                    if (r1_Right && !r2_Right) r1.isRightTop = true;
                    if (r2_Left && !r1_Left) r2.isLeftBottom = true;
                    if (r2_Right && !r1_Right) r2.isRightBottom = true;
                }
                if (-Settings.radius <= (r1.x - (r2.x + r2.width)) && (r1.x - (r2.x + r2.width)) <= 0)
                {
                    if (r1_Top) r1.isLeftTop = true;
                    if (r1_Bottom) r1.isLeftBottom = true;
                    if (r2_Top) r2.isRightTop = true;
                    if (r2_Bottom) r2.isRightBottom = true;
                    if (r1_Top && !r2_Top) r1.isTopLeft = true;
                    if (r1_Bottom && !r2_Bottom) r1.isBottomLeft = true;
                    if (r2_Top && !r1_Top) r2.isTopRight = true;
                    if (r2_Bottom && !r1_Bottom) r2.isBottomRight = true;
                }
                if (0 <= ((r1.x + r1.width) - r2.x) && ((r1.x + r1.width) - r2.x) <= Settings.radius)
                {
                    if (r1_Top) r1.isRightTop = true;
                    if (r1_Bottom) r1.isRightBottom = true;
                    if (r2_Top) r2.isLeftTop = true;
                    if (r2_Bottom) r2.isLeftBottom = true;
                    if (r1_Top && !r2_Top) r1.isTopRight = true;
                    if (r1_Bottom && !r2_Bottom) r1.isBottomRight = true;
                    if (r2_Top && !r1_Top) r2.isTopLeft = true;
                    if (r2_Bottom && !r1_Bottom) r2.isBottomLeft = true;
                }
                if (0 <= ((r1.y + r1.height) - r2.y) && ((r1.y + r1.height) - r2.y) <= Settings.radius)
                {
                    if (r1_Left) r1.isBottomLeft = true;
                    if (r1_Right) r1.isBottomRight = true;
                    if (r2_Left) r2.isTopLeft = true;
                    if (r2_Right) r2.isTopRight = true;
                    if (r1_Left && !r2_Left) r1.isLeftBottom = true;
                    if (r1_Right && !r2_Right) r1.isRightBottom = true;
                    if (r2_Left && !r1_Left) r2.isLeftTop = true;
                    if (r2_Right && !r1_Right) r2.isRightTop = true;
                }
            }
        }
    }
    Item {
        id: _container
        anchors.fill: parent
        Modules.Clock {
            id: _clock
            onPositionChanged: _top.anguliaCheck()
        }
        Angulia {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: edge
            anchors.rightMargin: edge
            forceTopLeft: true
            forceTopRight: true
        }
        Angulia {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            forceLeftTop: true
            forceLeftBottom: true
        }
        Angulia {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            forceRightTop: true
            forceRightBottom: true
        }
        Angulia {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: edge
            anchors.rightMargin: edge
            forceBottomLeft: true
            forceBottomRight: true
        }
    }
}