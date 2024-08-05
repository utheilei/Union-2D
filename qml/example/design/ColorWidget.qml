import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import QtQuick.Controls 1.4 as Old
import utk.model 1.0
import "../../controls"

ScrollView {
    id: scrollView
    clip: true
    property var tableModelData
    ListModel {
        id: colorModel
        ListElement {
            itemName: "品牌蓝"
            itemColor: "#1677FF"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "深紫蓝"
            itemColor: "#5A54F9"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "品牌紫"
            itemColor: "#9E339F"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "紫红色"
            itemColor: "#ED4192"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "品牌红"
            itemColor: "#E0282E"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "品牌橙"
            itemColor: "#F4801A"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "品牌黄"
            itemColor: "#F2BD27"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "品牌绿"
            itemColor: "#00B96B"
            textColor: "#FFFFFF"
        }
    }

    ListModel {
        id: functioncolorModel
        ListElement {
            itemName: "成功"
            itemColor: UTheme.SuccessBackground
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "失败"
            itemColor: UTheme.ErrorBackground
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "警告"
            itemColor: UTheme.WarningBackground
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "信息"
            itemColor: UTheme.InformationBackground
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "离线"
            itemColor: UTheme.OfflineBackground
            textColor: "#FFFFFF"
        }
    }

    ListModel {
        id: textcolorModel
        ListElement {
            itemName: "普通文本"
            itemColor: UTheme.Text
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "高亮文本"
            itemColor: UTheme.HighlightedText
            textColor: "#000000"
        }
        ListElement {
            itemName: "占位符文本"
            itemColor: UTheme.PlaceholderText
            textColor: "#FFFFFF"
        }
    }

    ListModel {
        id: backgroudcolorModel
        ListElement {
            itemName: "白色"
            itemColor: "#FFFFFF"
            textColor: "#000000"
        }
        ListElement {
            itemName: "暗黑"
            itemColor: "#000000"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "明青"
            itemColor: "#5cdbd3"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "酱紫"
            itemColor: "#b37feb"
            textColor: "#FFFFFF"
        }
        ListElement {
            itemName: "洋红"
            itemColor: "#ff85c0"
            textColor: "#FFFFFF"
        }
    }

    Component {
        id: colorComponent
        Rectangle {
            width: 200
            height: 130
            color: (typeof itemColor === "string") ? itemColor : UTheme.color(itemColor)
            radius: 8
            Column {
                spacing: 20
                anchors.centerIn: parent
                Label {
                    text: itemName
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: textColor
                }
                Label {
                    id: nameLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: (typeof itemColor === "string") ? itemColor : qmlHelper.colorName(UTheme.color(itemColor))
                    color: textColor
                }
            }
            MouseArea {
                anchors.fill: parent
                property bool isEnter: false
                cursorShape: isEnter ? Qt.ArrowCursor : Qt.PointingHandCursor
                onClicked: {
                    qmlHelper.clipboardCopy(nameLabel.text)
                    var text = "颜色复制成功:" + nameLabel.text
                    window.showFloatingMessage(true, text, 3000)
                }
                onEntered: isEnter = true
                onExited: isEnter = false
            }
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30
        Label {
            font.pixelSize: 30
            font.bold: true
            color: UTheme.text
            text: qsTr("Color颜色")
        }
        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       在Union-2D中，颜色是其中一个重要的设计元素，能够影响整体风格和用户体验。通过合理的颜色搭配和运用，Union-2D可以为用户提供更好的界面交互和视觉效果。")
            wrapMode: Text.WordWrap
        }
        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("品牌色")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       品牌色是Union-2D中的核心颜色，一般用于突出重要元素和强调功能。用于建立品牌识别度和一致性。品牌色一般包括深色和浅色两种变体，用于不同UI元素的区分和配合。用户可以在主题界面进行修改。")
            wrapMode: Text.WordWrap
        }

        Flow {
            width: scrollView.width - 40
            height: Math.ceil(colorModel.count / (width / 220)) * 140
            spacing: 20
            Repeater {
                model: colorModel
                delegate: colorComponent
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("功能色")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       功能色是指用于特定场景、表达特殊语义的颜色，例如成功、失败、告警、信息、离线等状态。")
            wrapMode: Text.WordWrap
        }

        Flow {
            width: scrollView.width - 40
            height: Math.ceil(functioncolorModel.count / (width / 220)) * 140
            spacing: 20
            Repeater {
                model: functioncolorModel
                delegate: colorComponent
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("文字色")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       文字色是最基本的颜色元素，用于提供清晰的信息传达和良好的阅读体验。文字色一般包括主文本色和次要文本色等，用于区分不同文本内容和重要性。文字色的选择要考虑到可读性和对比度，确保用户可以轻松辨别文字内容。")
            wrapMode: Text.WordWrap
        }

        Flow {
            width: scrollView.width - 40
            height: Math.ceil(textcolorModel.count / (width / 220)) * 140
            spacing: 20
            Repeater {
                model: textcolorModel
                delegate: colorComponent
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("背景色")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       背景色是Union-2D中一个重要的部分，用于营造整体界面的氛围和风格。背景色一般包括主背景色、辅助背景色和特殊背景色等，用于区分不同区域和布局。背景色的选择要符合用户习惯和界面清晰度，避免干扰用户的阅读和操作。")
            wrapMode: Text.WordWrap
        }

        Flow {
            width: scrollView.width - 40
            height: Math.ceil(backgroudcolorModel.count / (width / 220)) * 140
            spacing: 20
            Repeater {
                model: backgroudcolorModel
                delegate: colorComponent
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
            text: qsTr("颜色的属性说明如下：")
        }

        UTableView {
            id: tableView
            width: scrollView.width - 40
            height: (rowCount + 1) * 36
            Old.TableViewColumn {
                title: qsTr("Token")
                role: "property"
                width: 216
                movable: false
            }
            Old.TableViewColumn {
                title: qsTr("类型")
                role: "type"
                width: 128
                movable: false
            }

            Old.TableViewColumn {
                title: qsTr("枚举值")
                role: "default"
                width: 148
                movable: false
            }

            Old.TableViewColumn {
                title: qsTr("说明")
                role: "note"
                width: tableView.resizeColumn()
                movable: false
                resizable: false
            }
            TableModel {
                id: tableModel
                horHeader: [qsTr("Token"), qsTr("类型"), qsTr("枚举值"), qsTr("说明")]
                modelData: tableModelData
            }
            model: tableModel
            Component.onCompleted: {
                tableModel.insertRoleName(1257, "property");
                tableModel.insertRoleName(1258, "type");
                tableModel.insertRoleName(1259, "default");
                tableModel.insertRoleName(1260, "note");
                tableModelData = qmlHelper.loadClassProperty("utheme")
            }
        }
        Item {
            id: name
            width: 100
            height: 20
        }
    }
}
