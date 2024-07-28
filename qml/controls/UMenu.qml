import QtQuick 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12

Menu {
    property bool layerEnabled: true
    property color backgroundColor: UTheme.base
    property color borderColor: UTheme.frameBorder
    property int menuRadius: 8
    id: menu
    topPadding: 4
    bottomPadding: 4
    leftPadding: 4
    rightPadding: 4

    delegate: UMenuItem {
        id: menuItem
    }

    background: Rectangle {
        implicitWidth: 160
        implicitHeight: 30
        color: backgroundColor
        antialiasing: true
        radius: menuRadius
        border.width: 1
        border.color: borderColor
        layer.enabled: layerEnabled
        layer.effect: DropShadow {
            horizontalOffset: 1
            verticalOffset: 1
            radius: 8
            samples: 9
            color: "black"
        }
    }
}
