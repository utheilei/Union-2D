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
        controlType: "linkButtonWidget"
    }

    ListModel {
        id: model
        Component.onCompleted: {
            append({"title": qsTr("超链接按钮"), itemComponent: buttonComponent, "text": "简介\n超链接按钮有三种类型：普通超链接按钮、警告超链接按钮和危险超链接按钮。"});
        }
    }
    Component {
        id: buttonComponent
        Item {
            id: name
            ULinkButton {
                id: generalButton
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
                text: qsTr("普通超链接按钮")
                onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/blob/develop/qml/controls/ULinkButton.qml")
            }
            ULinkButton {
                id: wainingButton
                anchors.leftMargin: 10
                anchors.left: generalButton.right
                anchors.top: generalButton.top
                text: qsTr("警告超链接按钮")
                textColor: UTheme.warningBackground
                onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/blob/develop/qml/controls/ULinkButton.qml")
            }
            ULinkButton {
                id: errorButton
                anchors.leftMargin: 10
                anchors.left: wainingButton.right
                anchors.top: wainingButton.top
                text: qsTr("危险超链接按钮")
                textColor: UTheme.errorBackground
                onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/blob/develop/qml/controls/ULinkButton.qml")
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
            text: qsTr("Link 按钮")
        }

        Label {
            id: describeLabel
            width: scrollView.width
            font.pixelSize: 14
            color: UTheme.text
            wrapMode: Text.WordWrap
            text: qsTr("常用的超链接按钮。")
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
                    text: "ULinkButton"
                    onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/blob/develop/qml/controls/ULinkButton.qml")
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
                tableModelData = qmlHelper.loadClassProperty("ulinkbutton")
            }
        }
    }
}
