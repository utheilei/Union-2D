import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import "../controls"

ScrollView {
    id: scrollView
    clip: true
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30
        Label {
            id: titleLabel
            font.pixelSize: 30
            font.bold: true
            color: UTheme.text
            text: qsTr("阴影特效")
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("阴影(DropShadow)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("对输入的图像alpha通道模糊，对结果着色，并将其放置在源对象后面以创建柔和的阴影。可以使用颜色属性更改阴影的颜色。阴影的位置可以通过水平偏移和垂直偏移属性进行更改。软阴影是通过使用高斯模糊实时模糊图像而创建的。实时执行模糊是一项代价高昂的操作。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Image {
                id: originalAibackground
                source: "qrc:/image/dropshadow.png"
                sourceSize: Qt.size(260, 289)
            }
            Item {
                width: 290
                height: 290
                Image {
                    id: aibackground
                    source: "qrc:/image/dropshadow.png"
                    sourceSize: Qt.size(260, 289)
                }

                DropShadow {
                    id: dropShadow
                    anchors.fill: aibackground
                    horizontalOffset: 0
                    verticalOffset: 20
                    radius: 8.0
                    samples: 17
                    color: "#000000"
                    source: aibackground
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["color:", "#000000"],["radius:", 8],["samples:", 17],["horizontalOffset:", 0],["verticalOffset:", 20],["spread:", 0]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {setDropShadow(dropShadow, index, text)}
                        }
                    }
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("内阴影(InnerShadow)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("默认情况下该效果会生成高质量的阴影图像，因此阴影的渲染速度会降低，特别是在阴影边缘被严重软化的情况下。对于需要更快渲染速度且不需要最高视觉质量的用例，可以将属性fast设置为true。需要开启OpenGL。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Image {
                id: originalInnerbackground
                source: "qrc:/image/dropshadow.png"
                sourceSize: Qt.size(260, 289)
            }
            Item {
                width: 290
                height: 290
                Image {
                    id: innerbackground
                    source: "qrc:/image/dropshadow.png"
                    sourceSize: Qt.size(260, 289)
                }

                InnerShadow {
                    id: innerShadow
                    anchors.fill: innerbackground
                    horizontalOffset: -3
                    verticalOffset: 3
                    radius: 8.0
                    samples: 17
                    color: "#ff0000"
                    source: innerbackground
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["color:", "#ff0000"],["radius:", 8],["samples:", 17],["horizontalOffset:", -3],["verticalOffset:", 3],["spread:", 0]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {setDropShadow(innerShadow, index, text)}
                        }
                    }
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("光晕特效(Glow)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("光晕”效果会模糊源的alpha通道，并用颜色对其进行着色，然后将其放置在源后面，从而在对象周围产生光晕或光晕。模糊边缘的质量可以使用样本和半径来控制，辉光的强度可以使用扩散来改变。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Image {
                id: originalGlowbackground
                source: "qrc:/image/dropshadow.png"
                sourceSize: Qt.size(260, 289)
            }
            Item {
                width: 290
                height: 290
                Image {
                    id: glowbackground
                    source: "qrc:/image/dropshadow.png"
                    sourceSize: Qt.size(260, 289)
                }

                Glow {
                    id: glow
                    anchors.fill: glowbackground
                    radius: 8.0
                    samples: 17
                    color: "#ff0000"
                    source: glowbackground
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["color:", "#ff0000"],["radius:", 8],["samples:", 17],["spread:", 0]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {setGlow(glow, index, text)}
                        }
                    }
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("矩形光晕特效(RectangularGlow)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("辉光的形状仅限于具有自定义角半径的矩形。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Item {
                width: 290
                height: 290
                RectangularGlow {
                    id: effect
                    anchors.fill: rect
                    glowRadius: 10
                    spread: 0.2
                    color: "#ff0000"
                    cornerRadius: rect.radius + glowRadius
                }

                Rectangle {
                    id: rect
                    color: "black"
                    anchors.centerIn: parent
                    width: Math.round(parent.width / 1.5)
                    height: Math.round(parent.height / 2)
                    radius: 25
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["color:", "#ff0000"],["cornerRadius:", 8],["glowRadius:", 17],["spread:", 0]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {setRectangularGlow(effect, index, text)}
                        }
                    }
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("快速模糊(FastBlur)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("FastBlur提供的模糊质量比GaussianBlur低，但渲染速度更快。FastBlur效果通过使用源内容缩小和双线性滤波的算法模糊源内容来软化源内容。在源内容快速变化且不需要最高模糊质量的情况下使用此效果。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Image {
                id: originalFastbackground
                source: "qrc:/image/aibackground.png"
                sourceSize: Qt.size(260, 192)
            }
            Item {
                width: 260
                height: 192
                Image {
                    id: fastbackground
                    source: "qrc:/image/aibackground.png"
                    sourceSize: Qt.size(260, 192)
                }
                FastBlur {
                    id: fastBlur
                    anchors.fill: fastbackground
                    source: fastbackground
                    radius: 32
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["radius:", 32]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {
                                if (0 === index) {
                                    fastBlur.radius = Number(text)
                                }
                            }
                        }
                    }
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("高斯模糊(GaussianBlur)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("GaussianBlur效果通过使用高斯函数计算效果的算法模糊图像来软化图像。该效果产生的质量高于FastBlur，但渲染速度较慢。")
            wrapMode: Text.WordWrap
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 9
            Image {
                id: originalGaussianbackground
                source: "qrc:/image/aibackground.png"
                sourceSize: Qt.size(260, 192)
            }
            Item {
                width: 260
                height: 192
                Image {
                    id: gaussianbackground
                    source: "qrc:/image/aibackground.png"
                    sourceSize: Qt.size(260, 192)
                }
                GaussianBlur {
                    id: gaussianBlur
                    anchors.fill: gaussianbackground
                    source: gaussianbackground
                    radius: 8
                    samples: 16
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Repeater {
                    model: [["radius:", 8],["samples:", 8],["deviation:", 17]]
                    Row {
                        width: 400
                        height: 40
                        spacing: 10
                        Text {
                            width: 110
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                            onReturnPressed: {setGaussianBlur(gaussianBlur, index, text)}
                        }
                    }
                }
            }
        }
    }
    function setDropShadow(object, index, text) {
        switch(index) {
        case 0:
            object.color = text
            break
        case 1:
            object.radius = Number(text)
            break
        case 2:
            object.samples = Number(text)
            break
        case 3:
            object.horizontalOffset = Number(text)
            break
        case 4:
            object.verticalOffset = Number(text)
            break
        default:
            object.spread = Number(text)
            break
        }
    }

    function setGlow(object, index, text) {
        switch(index) {
        case 0:
            object.color = text
            break
        case 1:
            object.radius = Number(text)
            break
        case 2:
            object.samples = Number(text)
            break
        default:
            object.spread = Number(text)
            break
        }
    }

    function setRectangularGlow(object, index, text) {
        switch(index) {
        case 0:
            object.color = text
            break
        case 1:
            object.cornerRadius = Number(text)
            break
        case 2:
            object.glowRadius = Number(text)
            break
        default:
            object.spread = Number(text)
            break
        }
    }

    function setGaussianBlur(object, index, text) {
        switch(index) {
        case 0:
            object.radius = Number(text)
            break
        case 1:
            object.samples = Number(text)
            break
        default:
            object.deviation = Number(text)
            break
        }
    }
}
