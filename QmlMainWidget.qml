import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "./controls"

Rectangle {
    id: mainRectangle
    color: "transparent"
    radius: 20

    property var listWidget: [accountWidget, unionIDWidget, displayWidget, defaultAppWidget, netWorkWidget]

    HLListView {
        id: listView
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width/5
        model: qmlHelper.listModel()
        iconVisible: true
        clip: true
        onCurrentIndexChanged: rightRectangle.setCurrentIndex(currentIndex)
        leftMargin: 10
        rightMargin: 10
        topMargin: 10
        bottomMargin: 10
    }

    Item {
        id: rightRectangle
        anchors.left: listView.right
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
