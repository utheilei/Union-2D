import QtQuick 2.7
import QtQuick.Controls 2.4

ComboBox {
    id: control
    x: 300
    y: 60
    model: ["First", "Second", "Third"]

    delegate: ItemDelegate {
        width: control.width
        background: Rectangle {
            height: 30
            opacity: enabled ? 1 : 0.3
            color: highlighted ? UTheme.highlight : "transparent"
        }
        contentItem: Text {
            text: modelData
            color: UTheme.text
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

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
        leftPadding: 12
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
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

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
        }

        background: Rectangle {
            border.color: UTheme.highlight
            color: UTheme.window
            border.width: 1
            radius: 2
        }
    }
}
