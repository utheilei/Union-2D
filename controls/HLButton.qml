import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Button {
    id: closeButton
    property string btnColor: "transparent"
    property string hoverColor: HLTheme.button
    property int buttonPosition: 0
    hoverEnabled: true
    ToolTip.delay: 1000
    ToolTip.timeout: 5000
    ToolTip.visible: (ToolTip.text.length == 0) ? false : hovered

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 5
            Image {
                source: closeButton.icon.source
                sourceSize: Qt.size(closeButton.icon.width, closeButton.icon.height)
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: closeButton.text
                font: closeButton.font
                opacity: closeButton.enabled ? 1.0 : 0.3
                color: HLTheme.text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: 10
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

    onPressed: {
        btnColor = Qt.darker(HLTheme.button, 1.1)
    }

    onReleased: {
        btnColor = closeButton.hovered ? hoverColor : "transparent"
    }
}
