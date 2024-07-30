import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as Old
import "../controls"
import utk.model 1.0

ScrollView {
    id: scrollView
    clip: true
    property var tableModelData

    CodeDialog {
        id: codeDialog
        visible: false
        controlType: "buttonWidget"
    }

    ListModel {
        id: model
        Component.onCompleted: {
            append({"title": qsTr("常规按钮"), itemComponent: buttonComponent, "text": "简介\n按钮有五种类型：主要按钮、次要按钮、成功按钮、警告按钮和危险按钮。"});
            append({"title": qsTr("幽灵按钮"), itemComponent: ghostComponent, "text": "简介\n用于背景色比较复杂的地方，常用在首页/产品页等展示场景。"});
            append({"title": qsTr("图标文字按钮"), itemComponent: iconTextComponent, "text": "简介\n用于需要同时展示图标和文字的地方。"});
            append({"title": qsTr("圆形按钮"), itemComponent: cricleComponent, "text": "简介\n按钮有五种类型：主要按钮、次要按钮、成功按钮、警告按钮和危险按钮。"});
        }
    }
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

    Component {
        id: ghostComponent
        Item {
            id: name
            URoundedButton {
                id: primaryButton
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
                text: qsTr("主要按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.highlight
                backgroundPressedColor: Qt.darker(UTheme.highlight, 1.4)
                textColor: UTheme.highlight
                textHoverdColor: UTheme.highlightedText
                textPressedColor: UTheme.highlightedText
                borderWidth: 1
                borderColor: UTheme.highlight
                borderHoverdColor: UTheme.highlight
            }
            URoundedButton {
                anchors.leftMargin: 10
                anchors.left: primaryButton.right
                anchors.top: primaryButton.top
                text: qsTr("次要按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.button
                backgroundPressedColor: Qt.darker(UTheme.button, 1.4)
                borderWidth: 1
                borderColor: UTheme.button
                borderHoverdColor: UTheme.button
            }
            URoundedButton {
                id: successButton
                anchors.left: primaryButton.left
                anchors.topMargin: 10
                anchors.top: primaryButton.bottom
                text: qsTr("成功按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.successBackground
                backgroundPressedColor: Qt.darker(UTheme.successBackground, 1.4)
                textColor: UTheme.successBackground
                textHoverdColor: UTheme.highlightedText
                textPressedColor: UTheme.highlightedText
                borderWidth: 1
                borderColor: UTheme.successBackground
                borderHoverdColor: UTheme.successBackground
            }
            URoundedButton {
                id: wainingButton
                anchors.leftMargin: 10
                anchors.left: successButton.right
                anchors.top: successButton.top
                text: qsTr("警告按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.warningBackground
                backgroundPressedColor: Qt.darker(UTheme.warningBackground, 1.4)
                textColor: UTheme.warningBackground
                textHoverdColor: UTheme.highlightedText
                textPressedColor: UTheme.highlightedText
                borderWidth: 1
                borderColor: UTheme.warningBackground
                borderHoverdColor: UTheme.warningBackground
            }
            URoundedButton {
                id: errorButton
                anchors.leftMargin: 10
                anchors.left: wainingButton.right
                anchors.top: wainingButton.top
                text: qsTr("危险按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.errorBackground
                backgroundPressedColor: Qt.darker(UTheme.errorBackground, 1.4)
                textColor: UTheme.errorBackground
                textHoverdColor: UTheme.highlightedText
                textPressedColor: UTheme.highlightedText
                borderWidth: 1
                borderColor: UTheme.errorBackground
                borderHoverdColor: UTheme.errorBackground
            }
        }
    }

    Component {
        id: iconTextComponent
        Item {
            id: name
            URoundedButton {
                id: primaryButton
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
                text: qsTr("图标按钮")
                backgroundDefaultColor: UTheme.highlight
                textColor: UTheme.highlightedText
                icon.source: "qrc:/icon/" + UTheme.themeName + "/dark.svg"
            }
            URoundedButton {
                anchors.leftMargin: 10
                anchors.left: primaryButton.right
                anchors.top: primaryButton.top
                text: qsTr("次要按钮")
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: UTheme.button
                backgroundPressedColor: Qt.darker(UTheme.button, 1.4)
                borderWidth: 1
                borderColor: UTheme.button
                borderHoverdColor: UTheme.button
                icon.source: "qrc:/icon/" + UTheme.themeName + "/dark.svg"
            }
            URoundedButton {
                id: successButton
                anchors.left: primaryButton.left
                anchors.topMargin: 10
                anchors.top: primaryButton.bottom
                text: qsTr("成功按钮")
                backgroundDefaultColor: UTheme.successBackground
                textColor: UTheme.highlightedText
                icon.source: "qrc:/icon/" + UTheme.themeName + "/dark.svg"
            }
            URoundedButton {
                id: wainingButton
                anchors.leftMargin: 10
                anchors.left: successButton.right
                anchors.top: successButton.top
                text: qsTr("警告按钮")
                backgroundDefaultColor: UTheme.warningBackground
                textColor: UTheme.highlightedText
                icon.source: "qrc:/icon/" + UTheme.themeName + "/dark.svg"
            }
            URoundedButton {
                id: errorButton
                anchors.leftMargin: 10
                anchors.left: wainingButton.right
                anchors.top: wainingButton.top
                text: qsTr("危险按钮")
                backgroundDefaultColor: UTheme.errorBackground
                textColor: UTheme.highlightedText
                icon.source: "qrc:/icon/" + UTheme.themeName + "/dark.svg"
            }
        }
    }

    Component {
        id: cricleComponent
        Item {
            id: name
            URoundedButton {
                id: primaryButton
                width: 40
                height: 40
                buttonRadius: 20
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
                backgroundDefaultColor: UTheme.highlight
                icon.source: "qrc:/icon/" + UTheme.themeName + "/light.svg"
            }
            URoundedButton {
                width: 40
                height: 40
                buttonRadius: 20
                anchors.leftMargin: 10
                anchors.left: primaryButton.right
                anchors.top: primaryButton.top
                backgroundDefaultColor: "transparent"
                backgroundHoverdColor: Qt.darker(UTheme.informationBackground, 0.6)
                backgroundPressedColor : UTheme.informationBackground
                borderWidth: 1
                icon.source: "qrc:/icon/" + UTheme.themeName + "/light.svg"
            }
            URoundedButton {
                width: 40
                height: 40
                buttonRadius: 20
                id: successButton
                anchors.left: primaryButton.left
                anchors.topMargin: 10
                anchors.top: primaryButton.bottom
                backgroundDefaultColor: UTheme.successBackground
                icon.source: "qrc:/icon/" + UTheme.themeName + "/light.svg"
            }
            URoundedButton {
                id: wainingButton
                width: 40
                height: 40
                buttonRadius: 20
                anchors.leftMargin: 10
                anchors.left: successButton.right
                anchors.top: successButton.top
                backgroundDefaultColor: UTheme.warningBackground
                icon.source: "qrc:/icon/" + UTheme.themeName + "/light.svg"
            }
            URoundedButton {
                id: errorButton
                width: 40
                height: 40
                buttonRadius: 20
                anchors.leftMargin: 10
                anchors.left: wainingButton.right
                anchors.top: wainingButton.top
                backgroundDefaultColor: UTheme.errorBackground
                icon.source: "qrc:/icon/" + UTheme.themeName + "/light.svg"
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

        Item {
            width: scrollView.width
            height: 30
            Row {
                anchors.fill: parent
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("源码")
                    color: UTheme.text
                }
                ULinkButton {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "URoundedButton"
                    onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/blob/develop/qml/controls/URoundedButton.qml")
                }
            }
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
            width: scrollView.width
            Repeater {
                id: repeater
                model: model
                UCard {
                   width: 400
                   height: 240
                   switchText: "Disabled"
                   titleText: title
                   component: itemComponent
                   itemText: text
                   onSwitchClicked: item.enabled = !checked
                   onRightButtonClicked: codeDialog.open()
                }
            }
        }

        Label {
            id: apiLabel
            width: scrollView.width
            font.pixelSize: 16
            font.bold: true
            color: UTheme.text
            wrapMode: Text.WordWrap
            text: qsTr("API")
        }

        Label {
            id: apiDescribeLabel
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("按钮的属性说明如下：")
        }

        UTableView {
            id: tableView
            width: scrollView.width
            height: (rowCount + 1) * 36
            Old.TableViewColumn {
                title: qsTr("属性")
                role: "property"
                width: 160
                movable: false
            }
            Old.TableViewColumn {
                title: qsTr("说明")
                role: "note"
                width: 320
                movable: false
            }

            Old.TableViewColumn {
                title: qsTr("类型")
                role: "type"
                width: 80
                movable: false
            }

            Old.TableViewColumn {
                title: qsTr("默认值")
                role: "default"
                width: tableView.resizeColumn()
                movable: false
                resizable: false
            }
            TableModel {
                id: tableModel
                horHeader: [qsTr("属性"), qsTr("说明"), qsTr("类型"), qsTr("默认值")]
                modelData: tableModelData
            }
            model: tableModel
            Component.onCompleted: {
                tableModel.insertRoleName(1257, "property");
                tableModel.insertRoleName(1258, "note");
                tableModel.insertRoleName(1259, "type");
                tableModel.insertRoleName(1260, "default");
                tableModelData = qmlHelper.loadClassProperty("uroundedbutton")
            }
        }
    }
}
