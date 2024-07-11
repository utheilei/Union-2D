import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    property alias color: rect.color
    property alias source: mask.source

    Component.onCompleted: mask.sourceSize = Qt.size(width, height)

    Rectangle {
        id: rect
        anchors.fill: parent
        visible: false
    }

    Image {
        id: mask
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        visible: true
    }

    OpacityMask {
        anchors.fill: parent
        cached: true
        source: rect
        maskSource: mask
    }
}
