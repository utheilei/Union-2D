import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "../controls"
import utk.model 1.0
import QtGraphicalEffects 1.0

ScrollView {
    id: scrollView
    clip: true

    ListModel {
        id: model
        ListElement {
            name: qsTr("开源")
            describe: "拥抱开源，让更多的开发和设计人员共创"
        }
        ListElement {
            name: qsTr("研发")
            describe: "帮助研发人员了解和使用产品"
        }
        ListElement {
            name: qsTr("组件")
            describe: "组件Demo，用户快速体验交互细节；帮助工程师快速开发"
        }
        ListElement {
            name: qsTr("资源")
            describe: "下载相关资源，提升产品开发效率"
        }
    }

    Column {
        anchors.fill: parent
        width: scrollView.width
        spacing: 10
        Item {
            width: scrollView.width
            height: 600
            Rectangle {
                x: scrollView.width/12
                y: 60
                width: 80
                height: 80
                gradient: Gradient {
                    GradientStop { position: 0.0; color: qmlHelper.colorAlpha(UTheme.successBackground, 100)}
                    GradientStop { position: 1.0; color: qmlHelper.colorAlpha(UTheme.successBackground, 200)}
                }
            }

            Rectangle {
                x: scrollView.width/8
                y: 300
                width: 200
                height: 200
                radius: 100
                gradient: Gradient {
                    GradientStop { position: 0.0; color: qmlHelper.colorAlpha(UTheme.informationBackground, 100)}
                    GradientStop { position: 1.0; color: qmlHelper.colorAlpha(UTheme.informationBackground, 200)}
                }
            }

            Rectangle {
                x: scrollView.width/3
                y: 200
                width: 120
                height: 120
                radius: 60
                gradient: Gradient {
                    GradientStop { position: 0.0; color: qmlHelper.colorAlpha(UTheme.warningBackground, 100)}
                    GradientStop { position: 1.0; color: qmlHelper.colorAlpha(UTheme.warningBackground, 200)}
                }
            }

            Label {
                id: titleLabel
                z: 10
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 30
                font.bold: true
                color: UTheme.text
                text: "Union-2D 1.0"
            }

            Label {
                id: describeLabel
                width: 600
                anchors.top: titleLabel.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                z: 10
                font.pixelSize: 14
                color: UTheme.text
                wrapMode: Text.WordWrap
                text: qsTr("       Union-2D是基于QML开发的一整套简单且实用的通用开发框架平台，有助于开发者快速进行项目开发")
            }

            Row {
                id: buttonRow
                anchors.top: describeLabel.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                URoundedButton {
                    id: primaryButton
                    text: qsTr("开始使用")
                    backgroundDefaultColor: UTheme.highlight
                    textColor: UTheme.highlightedText
                    onClicked: {navigationBar.switchNavigationBar(3)}
                }
                URoundedButton {
                    text: qsTr("设计规范")
                    backgroundDefaultColor: "transparent"
                    backgroundHoverdColor: UTheme.button
                    backgroundPressedColor: Qt.darker(UTheme.button, 1.4)
                    borderWidth: 1
                    borderColor: UTheme.button
                    borderHoverdColor: UTheme.button
                    onClicked: {navigationBar.switchNavigationBar(1)}
                }
            }
            Row {
                anchors.top: buttonRow.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                z: 10
                Repeater {
                    id: repeater
                    model: model
                    Rectangle {
                        id: rect
                        property bool isHoverd: false
                        width: 200
                        height: 100
                        z: 10
                        color: UTheme.base
                        border.width: 2
                        border.color: UTheme.frameBorder
                        radius: 8
                        Column {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 16
                            Label {
                                width: parent.width
                                color: UTheme.text
                                text: name
                                font.bold: true
                                font.pixelSize: 16
                            }
                            Label {
                                width: parent.width
                                color: UTheme.text
                                text: describe
                                wrapMode: Text.WordWrap
                            }
                        }
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            radius: 8.0
                            samples: 17
                            color: "#80000000"
                        }
                        NumberAnimation on scale {
                            to: 1.1
                            running: rect.isHoverd ? true : false
                            duration: 200
                        }
                        NumberAnimation on scale {
                            to: 1.0
                            running: rect.isHoverd ? false : true
                            duration: 200
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: rect.isHoverd = true
                            onExited: rect.isHoverd = false
                            onClicked: onItemClicked(index)
                        }
                    }
                }
            }
            Image {
                id: backgroudImage
                anchors.right: parent.right
                anchors.rightMargin: -100
                anchors.top: parent.top
                z: 0
                source: "qrc:/icon/" + UTheme.themeName + "/homepage.png"
                sourceSize: Qt.size(610, 580)
                transform: [Rotation {origin.x: backgroudImage.width/2; origin.y: backgroudImage.height/2; axis { x: 1; y: 0; z: 0 } angle: 18},
                            Rotation{origin.x: backgroudImage.width/2; origin.y: backgroudImage.height/2; axis { x: 0; y: 1; z: 0 } angle: -18}]
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPositionChanged: {
                        var yAngle = -(mouse.x - backgroudImage.width/2) / 15
                        var xAngle = -(mouse.y - backgroudImage.height/2) / 15
                        backgroudImage.transform[0].angle = xAngle
                        backgroudImage.transform[1].angle = yAngle
                    }
                }
            }
        }
    }
    function onItemClicked(index) {
        switch(index) {
        case 0:
            Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/tree/develop")
            break
        case 1:
            navigationBar.switchNavigationBar(2)
            break
        case 2:
            navigationBar.switchNavigationBar(3)
            break
        case 3:
            navigationBar.switchNavigationBar(4)
            break
        default:
            break
        }
    }
}
