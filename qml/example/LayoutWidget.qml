import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../controls"

ScrollView {
    id: scrollView
    clip: true
    ColumnLayout {
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
            Layout.preferredWidth: scrollView.width
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("锚布局是Qt Quick中较为特殊的布局方式，通过设置Item的anchors属性去调整元素的水平、垂直位置，有left、righit、top、bottom、horizontalCenter、verticalCenter、fill、centerIn等属性来调整元素的位置。")
            wrapMode: Text.WordWrap
        }

        Image {
            id: name
            source: "qrc:/image/layout.png"
            sourceSize: Qt.size(468, 250)
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            Layout.preferredWidth: scrollView.width
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("示例")
            wrapMode: Text.WordWrap
        }

        Item {
            Layout.preferredWidth: 360
            Layout.preferredHeight: 260
            Layout.alignment: Qt.AlignHCenter
            RowLayout {
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
                        }},
                        State {
                        name: "fill"
                        AnchorChanges {
                            target: myRect
                            anchors.top: parentRectangle.top
                            anchors.bottom: parentRectangle.bottom
                            anchors.left: parentRectangle.left
                            anchors.right: parentRectangle.right
                        }}
                    ]
                    Component.onCompleted: {parentRectangle.state = "centerIn"}
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                    RadioButton {
                        text: qsTr("TopLeft")
                        onClicked: {parentRectangle.state = "topleft"}
                    }
                    RadioButton {
                        text: qsTr("TopRight")
                        onClicked: {parentRectangle.state = "topright"}
                    }
                    RadioButton {
                        text: qsTr("BottomLeft")
                        onClicked: {parentRectangle.state = "bottomleft"}
                    }
                    RadioButton {
                        text: qsTr("BottomRight")
                        onClicked: {parentRectangle.state = "bottomright"}
                    }
                    RadioButton {
                        checked: true
                        text: qsTr("CenterIn")
                        onClicked: {parentRectangle.state = "centerIn"}
                    }
                    RadioButton {
                        text: qsTr("Fill")
                        onClicked: {parentRectangle.state = "fill"}
                    }
                }
            }
        }
    }
}
