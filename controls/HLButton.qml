import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Button {
    id: closeButton
    property string btnColor: "transparent"
    property string hoverColor: "#DCD6D6"
    property int buttonPosition: 0
    hoverEnabled: true

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: 20
        color: closeButton.btnColor
        border.width: 0

        Rectangle {
            implicitWidth: parent.width/2
            implicitHeight: parent.height/2
            anchors.left: parent.left
            anchors.top: parent.top
            color: closeButton.btnColor
            border.width: 0
            visible: buttonPosition !== 1
        }

        Rectangle {
            implicitWidth: parent.width/2
            implicitHeight: parent.height/2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: closeButton.btnColor
            border.width: 0
            visible: buttonPosition !== 2
        }

        Rectangle {
            implicitWidth: parent.width/2
            implicitHeight: parent.height/2
            anchors.right: parent.right
            anchors.top: parent.top
            color: closeButton.btnColor
            border.width: 0
            visible: buttonPosition !== 3
        }

        Rectangle {
            implicitWidth: parent.width/2
            implicitHeight: parent.height/2
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: closeButton.btnColor
            border.width: 0
            visible: buttonPosition !== 4
        }
    }

    onHoveredChanged: {
        btnColor = closeButton.hovered ? hoverColor : "transparent"
    }
}
