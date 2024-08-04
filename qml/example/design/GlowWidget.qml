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
}
