import QtQuick 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import "./controls"

Menu {
    id: menu

    Action { text: qsTr("Tool Bar"); checkable: true }
    Action { text: qsTr("Side Bar"); checkable: true; checked: true }
    Action { text: qsTr("Status Bar"); checkable: true; checked: true }
    Action { text: "test1"; }
    Action { text: "test1"; }
    Action { text: "test1" }
    Action { text: "test1" }
    MenuSeparator {
        contentItem: Rectangle {
            implicitWidth: 160
            implicitHeight: 2
            color: "gray"
        }
    }

    Menu {
        title: qsTr("Advanced")
        MenuItem {
            text: "test1"
        }
        MenuItem {
            text: "test2"
        }
    }

    topPadding: 2
    bottomPadding: 2
    leftPadding: 2
    rightPadding: 2

    delegate: MenuItem {
        id: menuItem
        implicitWidth: 200
        implicitHeight: 30

        arrow: Canvas {
            x: parent.width - width
            width: 40
            height: 22
            visible: menuItem.subMenu
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "#404040"
                ctx.moveTo((width - 15)/2, (height - 18)/2)
                ctx.lineTo((width + 15)/2, height / 2)
                ctx.lineTo((width - 15)/2, (height + 18)/2)
                ctx.closePath()
                ctx.fill()
            }
        }

        contentItem: Text {
            leftPadding: menuItem.indicator.width
            rightPadding: menuItem.arrow.width
            text: menuItem.text
            font: menuItem.font
            color: "red"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 22
            radius: 2
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ? "#90c8f6" : "transparent"
        }
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 22
        radius: 8
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 1
            verticalOffset: 1
            radius: 8
            samples: 9
            source: aasdf
            color: "black"
        }
    }
}
