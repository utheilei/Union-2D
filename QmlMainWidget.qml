import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "./controls"

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
        color: windowTheme.base
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width/5
        radius: 8
        HLListView {
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

    HLEdgeButton {
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

        Component.onCompleted: {
            windowTheme.themeChanged.connect(onThemeChanged)
        }

        function onThemeChanged() {
            setExpand(edgeButton.expand)
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
            color: "green"
            visible: true
            radius: 8
            HLCalendar {
               anchors.centerIn: parent
            }

            HLCircleButton {
                x: 10
                y: 10
            }

            HLComboBox {}

            HLLineEdit {
                x: 60
                y: 60
                onReturnPressed: {
                    showAlertMessage("HLLineEdit", 3000)
                }
            }

            HLPassWordLineEdit {
                x: 60
                y: 100
                onReturnPressed: {
                    showAlertMessage("HLPassWordLineEdit", 3000)
                }
            }

            HLWaterProgress {
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
        }

        Rectangle {
            id: unionIDWidget
            anchors.fill: parent
            color: "red"
            visible: false
            radius: 8
        }

        Rectangle {
            id: displayWidget
            anchors.fill: parent
            color: "yellow"
            radius: 8
            visible: false
        }

        Rectangle {
            id: defaultAppWidget
            anchors.fill: parent
            color: "blue"
            radius: 8
            visible: false
        }

        Rectangle {
            id: netWorkWidget
            anchors.fill: parent
            color: "darkGreen"
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
