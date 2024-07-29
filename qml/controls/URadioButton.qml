import QtQuick 2.7
import QtQuick.Controls 2.4

RadioButton {
    id: control
    property color checkedColor: UTheme.highlight

    indicator: Rectangle {
        width: control.height - 6
        height: control.height - 6
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        radius: control.height / 2
        border.width: 1
        border.color: control.checked ? checkedColor : UTheme.text

        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            color: checkedColor
            radius: height / 2
            visible: control.checked
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: UTheme.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
