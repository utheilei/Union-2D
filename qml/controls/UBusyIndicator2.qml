import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

BusyIndicator {
    id: controlRoot

    property color headColor: UTheme.highlight
    property color tailColor: UTheme.base

    implicitWidth: 80
    implicitHeight: 80

    contentItem: Item {
        Rectangle {
            id: rect
            width: parent.width
            height: parent.height
            color: Qt.rgba(0, 0, 0, 0)
            radius: width / 2
            border.width: width / 6
            visible: false
        }

        ConicalGradient {
            width: rect.width
            height: rect.height
            gradient: Gradient {
                GradientStop { position: 0.0; color: tailColor }
                GradientStop { position: 1.0; color: headColor }
            }
            source: rect

            Rectangle {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: rect.border.width
                height: width
                radius: width / 2
                color: headColor
            }

            RotationAnimation on rotation {
                running: controlRoot.visible
                from: 0
                to: 360
                duration: 1800
                loops: Animation.Infinite
            }
        }
    }

}
