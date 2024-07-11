import QtQuick 2.7
import QtQuick.Particles 2.0
import "../"

Item {
    id: waterProgress
    property alias runing: timer.running
    property double xOffset: 0.5;
    property double speed: 0.6;
    property int value: 30;
    property double waveHeight: 2.5;
    property double waveWidth: 0.1;

    Canvas {
        id: mycanvas
        width: parent.width
        height: parent.height
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0,0,width,height);
            var gradient = ctx.createLinearGradient(width/2, height, width/2, 0);
            gradient.addColorStop(0.0, "#B1E7FA");
            gradient.addColorStop(1.0, "#2B1DFE");
            ctx.fillStyle = gradient;
            var radius = Math.min(parent.width, parent.height);
            drawBackground(ctx, radius);
            ctx.beginPath();
            ctx.ellipse(0, 0, radius, radius);
            ctx.clip();
            drawWave(ctx, radius);
        }

        Timer{
            id: timer
            running: true
            repeat: true
            interval: 100
            onTriggered:{
                xOffset = xOffset + speed;
                waveHeight = Math.random() + 2.5;
                parent.requestPaint();
            }
        }

        function drawBackground(ctx, radius) {
            ctx.beginPath();
            ctx.lineWidth = 0.01;
            ctx.ellipse(0, 0, radius, radius);
            ctx.fill();
            ctx.stroke();
        }

        function drawWave(ctx, radius) {
            var points = [];
            var points1 = [];
            for(var x = 0; x < radius; x++) {
                var y = -waveHeight * Math.sin(x*waveWidth + xOffset+1);
                var dY = mycanvas.height- mycanvas.height/100 * value;
                points.push([x, dY + y]);

                var y1 = -waveHeight * Math.sin(x*waveWidth + xOffset);
                points1.push([x, dY+ y1]);
            }

            drawPath(ctx, points, Qt.darker("#01C4FF", 1.1));
            drawPath(ctx, points1, "#01C4FF");
        }

        function drawPath(ctx, points, color) {
            ctx.save();
            ctx.beginPath();
            for(var x = 0; x < points.length; x++)
                ctx.lineTo(points[x][0], points[x][1]);
            ctx.lineTo(mycanvas.width, mycanvas.height);
            ctx.lineTo(0, mycanvas.height);
            ctx.lineTo(points[0][0], points[0][1]);
            ctx.fillStyle = color;
            ctx.fill();
            ctx.stroke();
        }
    }

    Text {
        id: waterProgressText
        anchors.centerIn: waterProgress
        text: value + "%"
        font.pointSize: Math.min(parent.width, parent.height)/5
        color: "white"
    }

    function setValue(barValue) {
        if (value !== barValue) {
            value = barValue
            mycanvas.requestPaint()
        }
    }
}
