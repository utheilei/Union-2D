import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

BusyIndicator {
    id: control
    width: 80
    height: 80
    property color background: UTheme.highlight
    style: BusyIndicatorStyle {
        indicator: Rectangle {
            id: back
            width: control.width
            height: control.height
            radius: width / 2
            color: "transparent"
            border.width: 10

            ConicalGradient {
                anchors.fill: back
                source: back
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFFFFF" }
                    GradientStop { position: 0.1 ; color: "#FFFFFF" }
                    GradientStop { position: 0.25 ; color: Qt.rgba(198/255,234/255,249/255,1) }
                    GradientStop { position: 0.5; color: Qt.rgba(136/255,212/255,243/255,1) }
                    GradientStop { position: 0.75; color: Qt.rgba(69/255,185/255,236/255,1) }
                    GradientStop { position: 1.0; color: Qt.rgba(4/255,162/255,229/255,1) }
                }
            }

            RotationAnimator on rotation {
                running: control.running
                loops: Animation.Infinite
                duration: 2000
                from: 0 ; to: 360
            }
        }
    }
}


