import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "../controls"
import utk.model 1.0

ScrollView {
    id: scrollView
    clip: true

    Column {
        anchors.fill: parent
        width: scrollView.width
        spacing: 10
        Item {
            width: scrollView.width
            height: 600
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
            Image {
                id: name
                anchors.right: parent.right
                anchors.rightMargin: -100
                anchors.top: parent.top
                z: 0
                source: "qrc:/icon/" + UTheme.themeName + "/homepage.jpg"
                sourceSize: Qt.size(610, 580)
                transform: [Rotation {origin.x: name.width/2; origin.y: name.height/2; axis { x: 1; y: 0; z: 0 } angle: 18},
                            Rotation{origin.x: name.width/2; origin.y: name.height/2; axis { x: 0; y: 1; z: 0 } angle: -18}]
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPositionChanged: {
                        var yAngle = -(mouse.x - name.width/2) / 15
                        var xAngle = -(mouse.y - name.height/2) / 15
                        name.transform[0].angle = xAngle
                        name.transform[1].angle = yAngle
                    }
                }
            }
        }
    }
}
