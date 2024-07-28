import QtQuick 2.7

Item {
    id: svgicon
    width: 16
    height: 16

    property bool asynchronous: true

    property bool smooth: true

    property color color: "transparent"

    property string source

    property alias status: image.status

    Image {
        id: image
        asynchronous: svgicon.asynchronous
        anchors.fill: svgicon
        source:  svgicon.source
        sourceSize: Qt.size(svgicon.width, svgicon.height)
        smooth: svgicon.smooth
        fillMode: Image.PreserveAspectFit
    }

    ShaderEffect {
        id: shaderItem
        property variant source: image
        property color color: svgicon.color
        fragmentShader: "qrc:/svg.cso"
        anchors.fill: parent
        enabled: svgicon.enabled
        visible: svgicon.status === Image.Ready
    }
}
