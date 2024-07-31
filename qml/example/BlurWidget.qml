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
                                fastBlur.radius = Number(text)
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
