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

    indicator: Item {
        implicitWidth: 30
        implicitHeight: 30
        visible: checkable
        Image {
            anchors.centerIn: parent
            source: (windowTheme.theme == 0) ? "qrc:/icon/light/correct.svg" : "qrc:/icon/dark/correct.svg"
            sourceSize: Qt.size(18, 18)
            visible: checked
        }
    }

    arrow: Item {
        x: parent.width - width
        implicitWidth: 30
        implicitHeight: 30
        visible: menuItem.subMenu
        Image {
            anchors.centerIn: parent
            source: (windowTheme.theme == 0) ? "qrc:/icon/light/right.svg" : "qrc:/icon/dark/right.svg"
            sourceSize: Qt.size(16, 16)
        }
    }

    background: Rectangle {
        anchors.fill: parent
        radius: 4
        opacity: enabled ? 1 : 0.3
        color: menuItem.highlighted ? itemColor : "transparent"
    }
}
