import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../controls"
import utk.model 1.0

Item {
    id: listItem
    property var modelData
    property string title
    property alias model: fuzzyFilterProxyModel
    signal itemClicked(var index, var name)

    FuzzyFilterProxyModel {
        id: fuzzyFilterProxyModel
        filterKeyColumn: 0
        filterRole: 1258
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        Label {
            id: commonLabel
            font.pixelSize: 14
            font.bold: true
            text: title + "(" + (listView.children.length-1) + ")"
        }

        Flow {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20
            Repeater {
                id: repeater
                model: fuzzyFilterProxyModel
                UIconItem {
                    width: 216
                    height: 150
                    icon: "qrc:/icon/" + UTheme.themeName + "/" + iconName + ".svg"
                    label: itemName
                    onItemClicked: {listItem.itemClicked(index, label)}
                }
            }
            onChildrenChanged: {
                listItem.visible = (listView.children.length - 1) > 0
            }
        }
    }

    onModelDataChanged: {
        fuzzyFilterProxyModel.sourceTableModel().setModelData(modelData)
    }
}

