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
        indicator: Image {
            id: back
            width: control.width
            height: control.height
            source: "qrc:/icon/" + UTheme.themeName + "/loading.svg"
            sourceSize: Qt.size(control.width, control.height)

            RotationAnimator on rotation {
                running: control.running
                loops: Animation.Infinite
                duration: 1800
                from: 0 ; to: 360
            }
        }
    }
}


