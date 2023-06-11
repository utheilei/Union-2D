import QtQuick 2.7
import QtQuick.Particles 2.0

Item {
    id: edgeButton
    property color triangleColor: "#2c94f7"
    property int triangleHeight: 4
    property int triangleWidth: 8
    property bool expand: true
    signal expandStatusChanged(var isExpand)
    Canvas {
        id: mycanvas
        width: parent.width
        height: parent.height
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0,0,width,height);
            drawPath(ctx, triangleColor);
            drawTriangle(ctx, triangleColor);
        }

        function drawTriangle(ctx, color) {
            ctx.beginPath();
            ctx.lineWidth = 0;
            if (expand) {
                ctx.moveTo((width - triangleHeight)/2,height/2);
                ctx.lineTo((width - triangleHeight)/2 + triangleHeight, (height/2 - triangleWidth/2));
                ctx.lineTo((width - triangleHeight)/2 + triangleHeight, (height/2 + triangleWidth/2));
            } else {
                ctx.moveTo((width - triangleHeight)/2, (height/2 - triangleWidth/2));
                ctx.lineTo((width - triangleHeight)/2 + triangleHeight, height/2);
                ctx.lineTo((width - triangleHeight)/2, (height/2 + triangleWidth/2));
            }
            context.closePath();
            ctx.fillStyle = color;
            ctx.fill();
            ctx.stroke();
        }

        function drawPath(ctx, color) {
            ctx.save();
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.moveTo(0,0);
            ctx.lineTo(width, width);
            ctx.lineTo(width, height - width);
            ctx.lineTo(0, height);
            context.closePath();
            ctx.strokeStyle = color;
            ctx.fillStyle = "#ffffff";
            ctx.fill();
            ctx.stroke();
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            var isExpand = !expand
            setExpand(isExpand)
            expandStatusChanged(isExpand)
        }
    }

    function setExpand(isExpand) {
        expand = isExpand;
        mycanvas.requestPaint();
    }
}
