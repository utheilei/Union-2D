import QtQuick 2.7
import QtQuick.Controls 2.4

Button {
    id: control
    property color backgroundCheckedColor: UTheme.base
    property color backgroundDefaultColor: UTheme.button
    property color backgroundHoverdColor: Qt.darker(backgroundDefaultColor, 1.2)
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.4)
    property int buttonRadius: 8
    property int borderWidth: 0
    property color borderColor: UTheme.text
    property color borderHoverdColor: UTheme.informationBackground
    property color borderPressedColor: Qt.darker(borderHoverdColor, 1.4)
    property color textColor: UTheme.text
    property color textHoverdColor: textColor
    property color textPressedColor: textColor

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 5
            Image {
                enabled: control.enabled
                source: control.icon.source
                sourceSize: Qt.size(control.icon.width, control.icon.height)
                anchors.verticalCenter: parent.verticalCenter
                visible: true
            }
            Text {
                id: text
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                color: control.down ? textPressedColor : (control.hovered ? textHoverdColor : textColor)
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }

    background: Rectangle {
        clip: true
        border.width: borderWidth
        border.color: control.down ? borderPressedColor : (hovered ? borderHoverdColor : borderColor)
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: buttonRadius
        color: control.checked ? backgroundCheckedColor : (control.down ? backgroundPressedColor : (hovered ? backgroundHoverdColor : backgroundDefaultColor))
        antialiasing: true
    }
}
