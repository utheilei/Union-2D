﻿import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Button {
    property color btnColor: UTheme.highlight
    property int buttonStatus: 0
    hoverEnabled: true
    antialiasing: true
    width: 40
    height: 40

    signal buttonPressed()

    background: Canvas {
        id: mycanvas
        width: parent.width
        height: parent.height
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0,0,width,height);
            ctx.fillRule = Qt.OddEvenFill
            var radius = Math.min(parent.width, parent.height);

            if (buttonStatus > 0) {
                ctx.save();
                ctx.beginPath();
                ctx.ellipse(radius/4, radius/4, radius/2, radius/2);
                ctx.fillStyle = UTheme.dark
                ctx.fill();
                ctx.stroke();
            }

            ctx.beginPath();
            ctx.fillStyle = currentColor(buttonStatus)
            ctx.lineWidth = 0.001;
            ctx.ellipse(0, 0, radius, radius);
            ctx.rect(radius/4, radius/2-1, radius/2, 2);
            ctx.rect(radius/2-1, radius/4, 2, radius/2);
            ctx.fill();
            ctx.stroke();
        }

        function currentColor(status) {
            switch(status) {
            case 0:
                return btnColor
            case 1:
                return Qt.darker(btnColor, 1.2)
            case 2:
                return Qt.darker(btnColor, 1.4)
            default:
                return btnColor
            }
        }
    }

    onHoveredChanged: {
        mycanvas.requestPaint()
        buttonStatus = hovered ? 1 : 0
    }

    onPressed: {
        buttonPressed()
        buttonStatus = 2
        mycanvas.requestPaint()
    }

    onReleased: {
        buttonStatus = 1
        mycanvas.requestPaint()
    }
}
