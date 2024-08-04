import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import "../../controls"

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
                    fast: true
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
}
