import QtQuick 2.7
import QtQuick.Controls 2.4
import "../controls"

ScrollView {
    id: scrollView
    clip: true
    property var model: [[qsTr("常规按钮"), buttonComponent]]
    Component {
        id: buttonComponent
        Item {
            id: name
            URoundedButton {
                id: primaryButton
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
                text: qsTr("主要按钮")
                backgroundDefaultColor: UTheme.highlight
                textColor: UTheme.highlightedText
            }
            URoundedButton {
                anchors.leftMargin: 10
                anchors.left: primaryButton.right
                anchors.top: primaryButton.top
                text: qsTr("次要按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: Qt.darker(UTheme.informationBackground, 0.6)
                backgroundPressedColor : UTheme.informationBackground
                borderWidth: 1
            }
            URoundedButton {
                id: successButton
                anchors.left: primaryButton.left
                anchors.topMargin: 10
                anchors.top: primaryButton.bottom
                text: qsTr("成功按钮")
                backgroundDefaultColor: UTheme.successBackground
                textColor: UTheme.highlightedText
            }
            URoundedButton {
                id: wainingButton
                anchors.leftMargin: 10
                anchors.left: successButton.right
                anchors.top: successButton.top
                text: qsTr("警告按钮")
                backgroundDefaultColor: UTheme.warningBackground
                textColor: UTheme.highlightedText
            }
            URoundedButton {
                id: errorButton
                anchors.leftMargin: 10
                anchors.left: wainingButton.right
                anchors.top: wainingButton.top
                text: qsTr("危险按钮")
                backgroundDefaultColor: UTheme.errorBackground
                textColor: UTheme.highlightedText
            }
        }
    }

    Column {
        anchors.fill: parent
        spacing: 16
        Label {
            id: titleLabel
            font.pixelSize: 24
            font.bold: true
            color: UTheme.text
            text: qsTr("Button 按钮")
        }

        Label {
            id: describeLabel
            width: scrollView.width
            font.pixelSize: 14
            color: UTheme.text
            wrapMode: Text.WordWrap
            text: qsTr("常用的操作按钮。")
        }

        Label {
            id: codeLabel
            font.pixelSize: 16
            font.bold: true
            color: UTheme.text
            text: qsTr("代码演示")
        }

        Flow {
            id: flowView
            spacing: 20
            Repeater {
                id: repeater
                model: scrollView.model
                UCard {
                   width: 400
                   height: 240
                   switchText: "Disabled"
                   itemText: modelData[0]
                   component: modelData[1]
                   onSwitchClicked: item.enabled = !checked
                }
            }
        }
    }
}
