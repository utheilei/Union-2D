import QtQuick 2.7
import QtQuick.Particles 2.0

Item {
    id: edgeButton
    property int orientation: Qt.Vertical
    property color triangleColor: UTheme.highlight
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
            if (Qt.Vertical === orientation) {
                if (expand) {
                    ctx.moveTo((width - triangleHeight)/2, height/2);
                    ctx.lineTo((width - triangleHeight)/2 + triangleHeight, (height/2 - triangleWidth/2));
                    ctx.lineTo((width - triangleHeight)/2 + triangleHeight, (height/2 + triangleWidth/2));
                } else {
                    ctx.moveTo((width - triangleHeight)/2, (height/2 - triangleWidth/2));
                    ctx.lineTo((width - triangleHeight)/2 + triangleHeight, height/2);
                    ctx.lineTo((width - triangleHeight)/2, (height/2 + triangleWidth/2));
                }
            } else if (Qt.Horizontal === orientation) {
                if (expand) {
                    ctx.moveTo((width - triangleWidth)/2, (height/2 - triangleHeight/2));
                    ctx.lineTo(width/2, (height/2 + triangleHeight/2));
                    ctx.lineTo((width + triangleWidth)/2, (height/2 - triangleHeight/2));
                } else {
                    ctx.moveTo((width - triangleWidth)/2, (height/2 + triangleHeight/2));
                    ctx.lineTo(width/2, (height/2 - triangleHeight/2));
                    ctx.lineTo((width + triangleWidth)/2, (height/2 + triangleHeight/2));
                }
            }
            context.closePath();
            ctx.fillStyle = color;
            ctx.fill();
            ctx.stroke();
        }

        function drawPath(ctx, color) {
            ctx.save();
            ctx.lineWidth = 1;
            ctx.beginPath();
            if (Qt.Vertical === orientation) {
                ctx.moveTo(0,0);
                ctx.lineTo(width, width);
                ctx.lineTo(width, height - width);
                ctx.lineTo(0, height);
            } else if (Qt.Horizontal === orientation) {
                ctx.moveTo(0, height);
                ctx.lineTo(height, 0);
                ctx.lineTo(width - height, 0);
                ctx.lineTo(width, height);
            }
            context.closePath();
            ctx.strokeStyle = color;
            ctx.fillStyle = UTheme.button;
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

    Component.onCompleted: {
        UTheme.applicationThemeChanged.connect(edgeButton.onThemeChanged)
    }

    Component.onDestruction: {
        UTheme.applicationThemeChanged.disconnect(edgeButton.onThemeChanged)
    }

    function onThemeChanged() {
        setExpand(edgeButton.expand)
    }
}
