import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../../controls"

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
            text: qsTr("常见布局")
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("锚布局(anchors)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("锚布局是Qt Quick中较为特殊的布局方式，通过设置Item的anchors属性去调整元素的水平、垂直位置，有left、righit、top、bottom、horizontalCenter、verticalCenter、fill、centerIn等属性来调整元素的位置。")
            wrapMode: Text.WordWrap
        }

        Image {
            id: name
            source: "qrc:/image/layout.png"
            sourceSize: Qt.size(468, 250)
            anchors.horizontalCenter: parent.horizontalCenter
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
            Rectangle {
                id: parentRectangle
                Layout.fillHeight: true
                Layout.preferredWidth: 260
                border.width: 1
                border.color: UTheme.splitLineBackground
                color: "transparent"
                Rectangle {
                    id: myRect
                    color: UTheme.successBackground
                    width: 100
                    height: 100
                }
                states: [
                    State {
                        name: "topleft"
                        AnchorChanges {
                            target: myRect
                            anchors.top: parentRectangle.top
                            anchors.left: parentRectangle.left
                        }},
                    State {
                        name: "topright"
                        AnchorChanges {
                            target: myRect
                            anchors.top: parentRectangle.top
                            anchors.right: parentRectangle.right
                        }},
                    State {
                        name: "bottomleft"
                        AnchorChanges {
                            target: myRect
                            anchors.left: parentRectangle.left
                            anchors.bottom: parentRectangle.bottom
                        }},
                    State {
                        name: "bottomright"
                        AnchorChanges {
                            target: myRect
                            anchors.right: parentRectangle.right
                            anchors.bottom: parentRectangle.bottom
                        }},
                    State {
                        name: "centerIn"
                        AnchorChanges {
                            target: myRect
                            anchors.horizontalCenter: parentRectangle.horizontalCenter
                            anchors.verticalCenter: parentRectangle.verticalCenter
                        }}
                ]
                Component.onCompleted: {parentRectangle.state = "centerIn"}
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                URadioButton {
                    text: qsTr("TopLeft")
                    onClicked: {parentRectangle.state = "topleft"}
                }
                URadioButton {
                    text: qsTr("TopRight")
                    onClicked: {parentRectangle.state = "topright"}
                }
                URadioButton {
                    text: qsTr("BottomLeft")
                    onClicked: {parentRectangle.state = "bottomleft"}
                }
                URadioButton {
                    text: qsTr("BottomRight")
                    onClicked: {parentRectangle.state = "bottomright"}
                }
                URadioButton {
                    checked: true
                    text: qsTr("CenterIn")
                    onClicked: {parentRectangle.state = "centerIn"}
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("行定位(Row)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("Row是一种将其子项沿单行定位的类型。它可以作为一种方便的方法，在不使用锚的情况下水平定位一系列物品。")
            wrapMode: Text.WordWrap
        }

        Row {
            spacing: 10
            Rectangle { color: UTheme.errorBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.successBackground; width: 70; height: 100 }
            Rectangle { color: UTheme.informationBackground; width: 100; height: 70 }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("列定位(Column)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("Column是一种沿着单个列定位其子项的类型。它可以作为一种方便的方式，在不使用锚的情况下垂直定位一系列物品。")
            wrapMode: Text.WordWrap
        }

        Column {
            spacing: 10
            Rectangle { color: UTheme.errorBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.successBackground; width: 70; height: 100 }
            Rectangle { color: UTheme.informationBackground; width: 100; height: 70 }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("网格定位(Grid)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("网格是一种以网格形式定位其子项的类型。网格创建了一个足够大的单元格网格，可以容纳其所有子项，并将这些项从左到右、从上到下放置在单元格中。每个项目都位于其单元格的左上角，位置为(0,0)。网格默认为四列，并根据需要创建尽可能多的行以容纳其所有子项。可以通过设置行和列属性来限制行和列的数量。")
            wrapMode: Text.WordWrap
        }

        Grid {
            columns: 3
            spacing: 10
            Rectangle { color: UTheme.errorBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.successBackground; width: 70; height: 100 }
            Rectangle { color: UTheme.informationBackground; width: 100; height: 70 }
            Rectangle { color: UTheme.warningBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.highlight; width: 60; height: 60 }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("流定位(Flow)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("Flow项将其子项定位默认为从左到右排列，超出宽度自动换行。")
            wrapMode: Text.WordWrap
        }

        Flow {
            width: 400
            spacing: 10
            Rectangle { color: UTheme.errorBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.successBackground; width: 70; height: 100 }
            Rectangle { color: UTheme.informationBackground; width: 100; height: 70 }
            Rectangle { color: UTheme.warningBackground; width: 100; height: 100 }
            Rectangle { color: UTheme.highlight; width: 60; height: 60 }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("行布局(RowLayout)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("RowLayout用于将元素排列在一行中。‌这些布局方式允许元素根据窗口宽度的变化而调整大小，‌使得元素能够铺满整个窗口。")
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 6
            Rectangle {
                color: UTheme.successBackground
                Layout.fillWidth: true
                Layout.minimumWidth: 50
                Layout.preferredWidth: 100
                Layout.maximumWidth: 300
                Layout.minimumHeight: 150
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
            Rectangle {
                color: UTheme.warningBackground
                Layout.fillWidth: true
                Layout.minimumWidth: 100
                Layout.preferredWidth: 200
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
            Rectangle {
                color: UTheme.informationBackground
                Layout.fillWidth: true
                Layout.minimumWidth: 100
                Layout.preferredWidth: 300
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("列布局(ColumnLayout)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("ColumnLayout用于将元素排列在一列中。‌这些布局方式允许元素根据窗口宽度的变化而调整大小，‌使得元素能够铺满整个窗口。")
            wrapMode: Text.WordWrap
        }

        ColumnLayout {
            spacing: 6
            Rectangle {
                Layout.alignment: Qt.AlignCenter
                color: UTheme.errorBackground
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignRight
                color: UTheme.successBackground
                Layout.preferredWidth: 100
                Layout.preferredHeight: 130
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.informationBackground
                Layout.preferredWidth: 130
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("网格布局(GridLayout)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("GridLayout属于网格布局。并将这些项从左到右、从上到下放置在单元格中。")
            wrapMode: Text.WordWrap
        }

        GridLayout {
            rowSpacing: 6
            columns: 3
            Rectangle {
                color: UTheme.errorBackground
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.successBackground
                Layout.preferredWidth: 100
                Layout.preferredHeight: 130
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.informationBackground
                Layout.preferredWidth: 130
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.warningBackground
                Layout.preferredWidth: 100
                Layout.preferredHeight: 130
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.highlight
                Layout.preferredWidth: 100
                Layout.preferredHeight: 130
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("栈布局(StackLayout)")
        }

        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("通过设置currentIndex属性可以修改当前可见项。该索引对应于StackLayout的子项的顺序。与大多数其他布局不同，子项目的Layout.fillWidth和Layout.fillHeight属性默认为true。因此，默认情况下，只要子项的Layout.maximumWidth或Layout.maximmumHeight不妨碍，子项就会填充以匹配StackLayout的大小。")
            wrapMode: Text.WordWrap
        }

        URoundedButton {
            text: "Swich"
            backgroundDefaultColor: UTheme.highlight
            textColor: UTheme.highlightedText
            onClicked: {
                stackLayout.currentIndex = (stackLayout.currentIndex + 1) % stackLayout.count
            }
        }

        StackLayout {
            id: stackLayout
            currentIndex: 0
            height: 300
            width: scrollView.width - 40
            Rectangle {
                color: UTheme.errorBackground
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.successBackground
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.informationBackground
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.warningBackground
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }

            Rectangle {
                color: UTheme.highlight
                Text {
                    anchors.centerIn: parent
                    color: UTheme.text
                    text: parent.width + 'x' + parent.height
                }
            }
        }
    }
}
