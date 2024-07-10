import QtQuick 2.7
import QtQuick.Controls 2.4

Button {
    id: control
    property color backgroundDefaultColor: HLTheme.button
    property color backgroundHoverdColor: Qt.darker(backgroundDefaultColor, 1.2)
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.4)
    property int buttonRadius: 8

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 5
            Image {
                source: control.icon.source
                sourceSize: Qt.size(control.icon.width, control.icon.height)
                anchors.verticalCenter: parent.verticalCenter
                visible: true
            }
            Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                color: HLTheme.text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: buttonRadius
        color: control.down ? backgroundPressedColor : (hovered ? backgroundHoverdColor : backgroundDefaultColor)
        antialiasing: true
    }
}
