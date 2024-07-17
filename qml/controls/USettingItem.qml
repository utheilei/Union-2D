import QtQuick 2.12
import QtQuick.Controls 2.15

URadiusRectangle {
    property alias component: myLoader.sourceComponent
    property alias itemText: settingText.text
    property alias itemIcon: settingIcon.source
    property alias itemFont: settingText.font
    property size iconSize: Qt.size(18, 18)

    Row {
        id: rowLayout
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 5
        Image {
            id: settingIcon
            sourceSize: iconSize
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            id: settingText
            FontMetrics {
                id: fontMetrics
                font: itemFont
            }
            color: UTheme.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            width: fontMetrics.boundingRect(text).width
        }

        Loader {
            id: myLoader
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
