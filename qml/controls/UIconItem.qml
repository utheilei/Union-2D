import QtQuick 2.12

Rectangle {
    id: item
    property alias icon: image.source
    property alias label: text.text
    property color backgroudColor: UTheme.button
    property color hoverColor: Qt.darker(backgroudColor, 1.1)
    property bool hoverd: false
    signal itemClicked

    implicitWidth: Math.max(text.implicitWidth, image.implicitWidth) + 20
    implicitHeight: image.implicitHeight + text.implicitHeight + 25
    radius: 8
    color: hoverd ? hoverColor : backgroudColor

    Image {
        id: image
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }

    Text {
        id: text
        wrapMode: Text.Wrap
        anchors.top: image.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: UTheme.text
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: itemClicked()
        onEntered: hoverd = true
        onExited: hoverd = false
    }
}
