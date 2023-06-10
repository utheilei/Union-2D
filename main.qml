import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.3
import "./FramelessWindow"

ApplicationWindow {
    property color tingeColor: Qt.rgba(255, 255, 255, 0.9)
    id: window
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window;
    visible: true
    minimumWidth: 500
    minimumHeight: 300
    width: 800
    height: 600
    title: qsTr("Union-2D")
    x: Screen.width/2 - width/2
    y: Screen.height/2 - height/2

    RectangularGlow {
        id: effect
        anchors.fill: rect
        glowRadius: 5
        spread: 0.2
        color: "black"
        cornerRadius: rect.radius + glowRadius
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.margins: 10
        radius: 10
        color: tingeColor
    }

    HLMenu {
        id: barMenu
    }

    FramelessWindow {
        anchors.fill: parent
        anchors.margins: 10
        parentObj: window

        HLEdgeButton {
            x:50
            y:50
            width: 10
            height: 80
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: rect
        }
    }
}
