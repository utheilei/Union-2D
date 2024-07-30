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
            spacing: 20
            Item {
                width: 290
                height: 290
                Image {
                    id: aibackground
                    source: "qrc:/image/dropshadow.png"
                    sourceSize: Qt.size(260, 289)
                }

                DropShadow {
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
                            text: modelData[0]
                            color: UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ULineEdit {
                            text: modelData[1]
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
