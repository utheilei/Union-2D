import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
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
            text: qsTr("更新日志")
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
}
