import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../../controls"

Item {
    property int currenTheme: UTheme.applicationTheme
    property int currenColor: UTheme.highlightIndex
    signal themeChanged(var index)
    signal highlightChanged(var color)
    ListModel {
        id: model
        ListElement {
            itemColor: "#ffffff"
            itemText: "白色"
        }
        ListElement {
            itemColor: "#000000"
            itemText: "暗黑"
        }
        ListElement {
            itemColor: "#5cdbd3"
            itemText: "明青"
        }
        ListElement {
            itemColor: "#b37feb"
            itemText: "酱紫"
        }
        ListElement {
            itemColor: "#ff85c0"
            itemText: "洋红"
        }
    }

    ListModel {
        id: colorModel
        ListElement {
            itemColor: "#1677FF"
        }
        ListElement {
            itemColor: "#5A54F9"
        }
        ListElement {
            itemColor: "#9E339F"
        }
        ListElement {
            itemColor: "#ED4192"
        }
        ListElement {
            itemColor: "#E0282E"
        }
        ListElement {
            itemColor: "#F4801A"
        }
        ListElement {
            itemColor: "#F2BD27"
        }
        ListElement {
            itemColor: "#00B96B"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30
        Label {
            id: titleLabel
            font.pixelSize: 30
            font.bold: true
            color: UTheme.text
            text: qsTr("我的主题")
        }

        Row {
            spacing: 20
            Layout.fillWidth: true
            height: 120
            Label {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: UTheme.text
                text: qsTr("主题:")
            }
            Repeater {
                model: model
                anchors.verticalCenter: parent.verticalCenter
                Column {
                    Rectangle {
                        id: item
                        width: 130
                        height: 90
                        color: (currenTheme === index) ? UTheme.highlight : "transparent"
                        radius: 8
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            color: itemColor
                            radius: 8
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {currenTheme = index; themeChanged(index)}
                        }
                    }
                    Label {
                        anchors.horizontalCenter: item.horizontalCenter
                        font.pixelSize: 14
                        color: UTheme.text
                        text: itemText
                    }
                }
            }
        }

        Row {
            spacing: 20
            Layout.fillWidth: true
            height: 40
            Label {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: UTheme.text
                text: qsTr("品牌色:")
            }
            Repeater {
                model: colorModel
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 32
                    height: 32
                    color: (currenColor === index) ? "#1677FF" : "transparent"
                    radius: 16
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        color: itemColor
                        radius: height/2
                        border.width: 1
                        border.color: UTheme.splitLineBackground
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {currenColor = index;UTheme.highlightIndex = index;highlightChanged(itemColor)}
                    }
                }
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
