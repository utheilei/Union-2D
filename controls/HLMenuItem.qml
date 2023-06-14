import QtQuick 2.12
import QtQuick.Controls 2.15

MenuItem {
    property color itemColor: windowTheme.highlight
    id: menuItem
    implicitHeight: 30
    contentItem: Text {
        leftPadding: menuItem.indicator.width
        rightPadding: menuItem.arrow.width
        text: menuItem.text
        font: menuItem.font
        color: windowTheme.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: parent
        radius: 4
        opacity: enabled ? 1 : 0.3
        color: menuItem.highlighted ? itemColor : "transparent"
    }
}
