import QtQuick 2.12

Rectangle {
    id: item
    property alias icon: image.source
    property alias label: text.text
    property color backgroudColor: "#d9d9d9"
    property color hoverColor: "#cccccc"
    signal itemClicked

    implicitWidth: Math.max(text.implicitWidth, image.implicitWidth) + 20
    implicitHeight: image.implicitHeight + text.implicitHeight + 25
    radius: 8
    color: backgroudColor

    SystemPalette {
        id: sPalette
        colorGroup: SystemPalette.Active
    }

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
        color: sPalette.text
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: itemClicked()
        onEntered: item.color = hoverColor
        onExited: item.color = backgroudColor
    }
}
