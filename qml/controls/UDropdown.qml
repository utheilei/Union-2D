import QtQuick 2.7
import QtQuick.Controls 2.4

Button {
    id: control
    property alias buttonMenu: popMenu
    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? Qt.darker(UTheme.highlight, 1.1) : UTheme.highlight;
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 2
        rightPadding: control.indicator.width + control.spacing

        text: control.text
        font: control.font
        color: UTheme.text
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 160
        implicitHeight: 30
        border.color: control.pressed ? Qt.darker(UTheme.highlight, 1.1) : UTheme.highlight
        border.width: 1
        color: UTheme.base
        radius: 2
    }

    UMenu {
        id: popMenu
        x: 0
        y: control.height
        menuRadius: 2
        layerEnabled: false
        backgroundColor: UTheme.window
        borderColor: UTheme.highlight
    }

    onPressed: {
        popMenu.visible = true
    }
}
