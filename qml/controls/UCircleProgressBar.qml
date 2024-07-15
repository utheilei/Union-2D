import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.12

Rectangle {
    id: back
    property int percent: 50
    property color foreground: UTheme.successBackground
    property color background: UTheme.button
    property color textColor: UTheme.text

    width: 120
    height: width
    radius: width / 2
    color: "transparent"
    border.width: 10
    border.color: percent === 100 ? foreground : background

    ConicalGradient {
        anchors.fill: back
        source: back
        enabled: percent != 100
        visible: enabled
        gradient: Gradient {
            GradientStop { position: 0.0; color: foreground }
            GradientStop { position: percent / 100 ; color: foreground }
            GradientStop { position: percent / 100 + 0.001; color: background }
            GradientStop { position: 1.0; color: background }
        }
    }

    Text {
        anchors.centerIn: parent
        text: percent + "%"
        color: textColor
        opacity: enabled ? 1.0 : 0.3
    }
}

