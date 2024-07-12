import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

CheckBox {
    id: control;
    property int checkBoxSize: 16

    indicator: Canvas {
        id: mycanvas
        width: checkBoxSize
        height: checkBoxSize
        anchors.verticalCenter: control.verticalCenter
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = 2
            ctx.beginPath();
            ctx.roundedRect(0, 0, checkBoxSize, checkBoxSize, 3, 3);
            ctx.clip();
            if (Qt.Unchecked === control.checkState)
            {
                ctx.strokeStyle = UTheme.highlight;
                ctx.stroke();
            }
            else
            {
                ctx.fillStyle = UTheme.highlight;
                ctx.fill();
            }

            if (Qt.Checked === control.checkState)
            {
                ctx.strokeStyle = "#FFFFFF";
                ctx.beginPath();
                ctx.moveTo(3, checkBoxSize/2);
                ctx.lineTo(checkBoxSize/2 - 1, checkBoxSize - 4);
                ctx.lineTo(checkBoxSize - 3, checkBoxSize/4);
                ctx.stroke();
            }
            else if (Qt.PartiallyChecked === control.checkState)
            {
                ctx.strokeStyle = "#FFFFFF";
                ctx.beginPath();
                ctx.moveTo(3, checkBoxSize/2);
                ctx.lineTo(checkBoxSize - 3, checkBoxSize/2);
                ctx.stroke();
            }
        }
    }
    contentItem: Text {
        color: UTheme.text;
        text: control.text;
        font: control.font
        anchors.verticalCenter: control.verticalCenter
        leftPadding: control.indicator.width + control.spacing;
        renderType: Text.NativeRendering;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignHCenter;
    }

    onCheckStateChanged: {
        mycanvas.requestPaint()
    }
}
