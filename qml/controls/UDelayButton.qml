import QtQuick 2.7
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

DelayButton {
    id: delayButton
    property color shadowColor: UTheme.successBackground
    property var gradient: Gradient {
        GradientStop { position: 0.0; color: "#ffffff" }
        GradientStop { position: 1.0; color: UTheme.successBackground }
    }
    Text {
        id: name
        text: Math.floor(progress * 100) + "%"
        anchors.centerIn: parent
        color: "black"
    }
    style: DelayButtonStyle {
        progressBarDropShadowColor: shadowColor
        progressBarGradient: gradient
    }
}

