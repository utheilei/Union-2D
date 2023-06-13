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
        color: "white"
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
        NumberAnimation on width { id: animation; to: 0; duration: 1000; running: false}
        NumberAnimation on width { id: animation1; to: parent.width/5; duration: 1000; running: false}
    }

    HLEdgeButton {
        id: edgeButton
        width: 10
        height: 60
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
            color: "green"
            visible: true
            HLCalendar {
               anchors.centerIn: parent
            }
        }

        Rectangle {
            id: unionIDWidget
            anchors.fill: parent
            color: "red"
            visible: false
        }

        Rectangle {
            id: displayWidget
            anchors.fill: parent
            color: "yellow"
            visible: false
        }

        Rectangle {
            id: defaultAppWidget
            anchors.fill: parent
            color: "blue"
            visible: false
        }

        Rectangle {
            id: netWorkWidget
            anchors.fill: parent
            color: "darkGreen"
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
