import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.12
import "../../controls"

Rectangle {
    id: back
    property color background: UTheme.highlight
    width: 120
    height: width
    radius: width / 2
    color: "transparent"
    border.width: 4
    border.color: UTheme.base
    ConicalGradient {
        anchors.fill: back
        source: back
        enabled: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: UTheme.base}
            GradientStop { position: 0.25; color: background}
            GradientStop { position: 0.50; color: background}
            GradientStop { position: 0.88; color: UTheme.base}
            GradientStop { position: 1.0; color: UTheme.base}
        }
    }
}
