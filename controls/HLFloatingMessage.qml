import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

ToolTip {
    id: control
    timeout: 3000
    height: 45
    width: iconSource.width + contentText.width + 35

    property alias iconSource: iconSource.source
    property int toolTipRadius: 8
    property size iconSize: Qt.size(30, 30)
    property int maxWidth

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.fill: parent
            leftPadding: 5
            rightPadding: 10
            spacing: 10
            Image {
                id: iconSource
                sourceSize: iconSize
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: contentText
                width: fontMetrics.boundingRect(control.text).width > maxWidth ? maxWidth : fontMetrics.boundingRect(control.text).width
                anchors.verticalCenter: parent.verticalCenter
                text: control.text
                font: control.font
                color: windowTheme.text
                opacity: control.enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: fontMetrics.boundingRect(control.text).width > maxWidth ? Text.ElideRight : Text.ElideNone
            }

            FontMetrics {
                id: fontMetrics
                font: control.font
            }
        }
    }

    background: Rectangle {
        color: windowTheme.base
        radius: toolTipRadius
        antialiasing: true
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 8.0
            samples: 17
            color: "#80000000"
        }
    }
}
