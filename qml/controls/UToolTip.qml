import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

ToolTip {
    id: control
    topPadding: 4
    bottomPadding: 4

    contentItem: Text {
        text: control.text
        font: control.font
        color: Qt.rgba(0.945, 0.224, 0.196, 1)
    }

    background: Rectangle {
        color: UTheme.base
        radius: 8
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 8.0
            samples: 17
            color: "#80000000"
        }
    }
}
