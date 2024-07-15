import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "./controls"
import utk.model 1.0

Rectangle {
    id: mainRectangle
    color: "transparent"
    radius: 20

    property var listWidget: [accountWidget, unionIDWidget, displayWidget, defaultAppWidget, netWorkWidget]

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            var isListView = qmlHelper.contains(Qt.rect(listView.x, listView.y, listView.width, listView.height), Qt.point(mouse.x, mouse.y))
            var isButton = qmlHelper.contains(Qt.rect(edgeButton.x, edgeButton.y, edgeButton.width, edgeButton.height), Qt.point(mouse.x, mouse.y))
            if (!edgeButton.expand) {
                edgeButton.visible = true
                return
            }
            if (isListView || isButton) {
                edgeButton.visible = true
            } else {
                edgeButton.visible = false
            }
        }
    }

    Rectangle {
        id: leftRectangle
        color: UTheme.base
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width/5
        radius: 8
        UListView {
            id: listView
            anchors.fill: parent
            model: qmlHelper.listModel()
            iconVisible: true
            clip: true
            onCurrentIndexChanged: rightRectangle.setCurrentIndex(currentIndex)
            leftMargin: 10
            rightMargin: 10
            topMargin: 10
            bottomMargin: 10
            onHoverChanged: {edgeButton.visible = isHovered}
        }
        NumberAnimation on width { id: animation; to: 0; duration: 500; running: false}
        NumberAnimation on width { id: animation1; to: parent.width/5; duration: 500; running: false}
    }

    UEdgeButton {
        id: edgeButton
        width: 10
        height: 80
        visible: false
        anchors.left: leftRectangle.right
        anchors.verticalCenter: leftRectangle.verticalCenter
        onExpandStatusChanged : {
            if (isExpand) {
                animation1.start()
            } else {
                animation.start()
            }
        }
    }

    Item {
        id: rightRectangle
        anchors.left: edgeButton.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        clip: true

        Rectangle {
            id: accountWidget
            anchors.fill: parent
            color: UTheme.base
            visible: true
            radius: 8
            UCalendar {
               anchors.centerIn: parent
            }

            UCircleButton {
                x: 10
                y: 10
            }

            UComboBox {}

            ULineEdit {
                x: 60
                y: 60
                onReturnPressed: {
                    showAlertMessage("HLLineEdit", 3000)
                }
            }

            UPassWordLineEdit {
                x: 60
                y: 100
                onReturnPressed: {
                    showAlertMessage("HLPassWordLineEdit", 3000)
                }
            }

            UWaterProgress {
                id: waterProgress
                x: 10
                y: 200
                width: 120
                height: 120
            }

            Slider {
                from: 0
                to: 100
                orientation: Qt.Horizontal
                onValueChanged: {
                    waterProgress.setValue(value)
                }
            }

            USearchLineEdit {
                x: 280
                y: 100
                onReturnPressed: {
                    showAlertMessage("HLSearchLineEdit", 3000)
                }
            }
        }

        Rectangle {
            id: unionIDWidget
            anchors.fill: parent
            color: UTheme.base
            visible: false
            radius: 8

            UButtonGroup {
                x:100
                y:100
                width: 140
                height: 60
                model: [["","qrc:/icon/dark/yes.svg"],["","qrc:/icon/dark/error.svg"]]
            }

            USwitch {
                x:280
                y:100
            }

            Rectangle {
                x:100
                y:200
                width: 140
                height: 60
                radius: 8
                color: UTheme.warningBackground
                border.color: UTheme.text
                border.width: 1
            }

            URoundedButton {
                x:280
                y:200
                width: 100
                height: 40
                text: "URoundedButton"
                textColor: UTheme.errorBackground
            }

            UCheckBox {
                x:400
                y:200
                text: "URoundedButton"
                checkState: Qt.Checked
            }

            UEdgeButton {
                id: edgeBtn
                orientation: Qt.Horizontal
                width: 80
                height: 10
                visible: true
                x:600
                y:200
            }
        }

        Rectangle {
            id: displayWidget
            anchors.fill: parent
            color: UTheme.base
            radius: 8
            visible: false

            URoundedButton {
                id: add
                x:10
                y:10
                text: "append"
                onClicked: {
                    treeView.treeViewModel.insertItem(0, ["append", "yes"])
                }
            }

            UTreeView {
                id: treeView
                anchors.top: add.bottom
                anchors.left: add.left
            }

            UProgressBar {
                id: bar
                anchors.top: treeView.bottom
                anchors.left: treeView.left
            }

            UCircleProgressBar {
                id: circleProgressBar
                anchors.topMargin: 50
                anchors.top: bar.bottom
                anchors.left: bar.left
            }

            UBusyIndicator {
                id: indicator
                anchors.topMargin: 20
                anchors.top: circleProgressBar.bottom
                anchors.left: circleProgressBar.left
            }
        }

        Rectangle {
            id: defaultAppWidget
            anchors.fill: parent
            color: UTheme.base
            radius: 8
            visible: false
        }

        Rectangle {
            id: netWorkWidget
            anchors.fill: parent
            color: UTheme.base
            radius: 8
            visible: false
        }

        function setCurrentIndex(index) {
            if (index >= listWidget.length)
                return

            for (var i=0; i<listWidget.length; i++) {
                if (listWidget[i] === undefined)
                    continue
                if (i === index)
                    listWidget[i].visible = true
                else
                    listWidget[i].visible = false
            }
        }
    }

    function setCurrentItem(index) {
        listView.currentIndex = index
    }
}
