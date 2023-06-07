﻿import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Button {
    id: control

    SystemPalette {
        id: sPalette
        colorGroup: SystemPalette.Active
    }

    property color backgroundDefaultColor: sPalette.button
    property color backgroundHoverdColor: Qt.darker(backgroundDefaultColor, 1.2)
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.4)
    property int buttonRadius: 10
    property color textColor: sPalette.text

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 5
            Image {
                source: control.icon.source
                sourceSize: Qt.size(control.icon.width, control.icon.height)
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                color: getTextColor()
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
//        layer.enabled: true
//        layer.effect: InnerShadow {
//            radius: 2
//            samples: 4
//            color: "#ffffff"
//            spread: 0.5
//        }
    }

    function getTextColor() {
        if (backgroundDefaultColor === sPalette.highlight)
            return sPalette.highlightedText
        if (textColor === sPalette.text)
            return control.down ? sPalette.highlight : sPalette.text
        else
            return textColor
    }
}
