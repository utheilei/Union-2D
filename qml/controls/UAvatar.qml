import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4

Item {
    id: root
    property alias borderColor: rect.border.color
    property alias source: name.source

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: root.height/2
        border.width: 1
        border.color: UTheme.button
    }

    Image {
        id: name
        anchors.fill: parent
        sourceSize: Qt.size(root.width - 2, root.height -2)
    }

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: root.height/2
        }
    }
}
