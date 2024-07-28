import QtQuick 2.12
import QtQuick.Controls 2.15

URadiusRectangle {
    property alias component: myLoader.sourceComponent
    property alias itemText: settingText.text
    property alias itemIcon: settingIcon.source
    property alias itemFont: settingText.font
    property size iconSize: Qt.size(18, 18)

    Image {
        id: settingIcon
        sourceSize: iconSize
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
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
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: settingIcon.right
        width: fontMetrics.boundingRect(text).width
    }

    Loader {
        id: myLoader
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 0
        anchors.right: parent.right
    }
}
