import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Button {
    id: closeButton
    property string btnColor: "transparent"
    property string hoverColor: UTheme.button
    property var buttonPosition: URadiusRectangle.ItemPosition.All
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
                color: UTheme.text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }

    background: URadiusRectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: 10
        itemColor: closeButton.btnColor
        itemPosition: buttonPosition
    }

    onHoveredChanged: {
        btnColor = closeButton.hovered ? hoverColor : "transparent"
    }

    onPressed: {
        btnColor = Qt.darker(UTheme.button, 1.1)
    }

    onReleased: {
        btnColor = closeButton.hovered ? hoverColor : "transparent"
    }
}
