import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4

Rectangle {
    id: root

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: 10
        }
    }
}
