import QtQuick 2.12
import QtQuick.Controls 2.15

Canvas {
    id: mycanvas
    enum ItemPosition {
        TopLeft = 0x0001,
        TopRight = 0x0010,
        BottomLeft = 0x0100,
        BottomRight = 0x1000,
        All = 0x1111
    }
    property color itemColor: UTheme.itemBackground
    property var itemPosition: URadiusRectangle.ItemPosition.All
    property int radius: 8

    antialiasing: true
    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0,0,width,height);
        ctx.fillRule = Qt.WindingFill
        ctx.beginPath();
        ctx.fillStyle = itemColor
        ctx.roundedRect(0, 0, width, height, radius, radius);
        if (itemPosition & URadiusRectangle.ItemPosition.TopLeft) {
            ctx.rect(0, 0, width/2, height/2)
        }
        if (itemPosition & URadiusRectangle.ItemPosition.BottomLeft) {
            ctx.rect(0, height/2, width/2, height/2)
        }
        if (itemPosition & URadiusRectangle.ItemPosition.TopRight) {
            ctx.rect(width/2, 0, width/2, height/2)
        }
        if (itemPosition & URadiusRectangle.ItemPosition.BottomRight) {
            ctx.rect(width/2, height/2, width/2, height/2)
        }
        ctx.fill();
    }

    onItemColorChanged: {mycanvas.requestPaint()}
    onItemPositionChanged: {mycanvas.requestPaint()}
    onRadiusChanged: {mycanvas.requestPaint()}
}

