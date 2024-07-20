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
    property var listMap: new Map([[0, accountWidget], [1, unionIDWidget], [2, displayWidget], [3, defaultAppWidget], [4, netWorkWidget]]);

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
        ListModel {
            id: leftModel
            ListElement {
                itemData: 0
                itemRole: UListView.ItemRoles.Member
                itemName: "ButtonWidgets"
                sourceUrl: "qrc:/image/button.svg"
            }
            ListElement {
                itemData: 1
                itemRole: UListView.ItemRoles.Member
                itemName: "InputWidgets"
                sourceUrl: "qrc:/image/inputedit.svg"
            }
            ListElement {
                itemData: 2
                itemRole: UListView.ItemRoles.Member
                itemName: "ProgressWidgets"
                sourceUrl: "qrc:/image/progress.svg"
            }
            ListElement {
                itemData: 3
                itemRole: UListView.ItemRoles.Member
                itemName: "DialogWidgets"
                sourceUrl: "qrc:/image/dialog.svg"
            }
            ListElement {
                itemData: 4
                itemRole: UListView.ItemRoles.Member
                itemName: "TooltipWidgets"
                sourceUrl: "qrc:/image/tooltip.svg"
            }
        }
        UListView {
            id: listView
            anchors.fill: parent
            model: leftModel
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
                model: [["","qrc:/icon/dark/success.svg"],["","qrc:/icon/dark/error.svg"]]
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
                    treeView.treeViewModel.insertItem(0, ["append", "success"])
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

            UAlert {
                id: successMessage
                x: 800
                y: 10
                maxWidth: 300
                visible: true
                text: "成功提示的文案"
            }

            UAlert {
                id: message
                x: 800
                y: 70
                alertColor: UTheme.informationBackground
                alertType: UAlert.AlertType.Message
                maxWidth: 300
                visible: true
                text: "消息提示的文案"
            }

            UAlert {
                id: wainingMessage
                x: 800
                y: 130
                alertColor: UTheme.warningBackground
                alertType: UAlert.AlertType.Waining
                maxWidth: 300
                visible: true
                text: "警告提示的文案"
            }

            UAlert {
                id: errorMessage
                x: 800
                y: 190
                alertColor: UTheme.errorBackground
                alertType: UAlert.AlertType.Error
                maxWidth: 300
                visible: true
                text: "错误提示的文案"
            }

            Component {
                id: switchComponent
                USwitch {
                }
            }

            ListModel {
                id: fruitModel
                Component.onCompleted: {
                    append({"text": "Apple", "iconName": "success", itemComponent: switchComponent});
                    append({"text": "Orange", "iconName": "success", itemComponent: switchComponent});
                    append({"text": "Banana", "iconName": "success", itemComponent: switchComponent});
                }
            }

            USettingGroup {
                id: group
                model: fruitModel
                spacing: 2
                x: 10
                y: 10
                width: 200
            }
        }

        Rectangle {
            id: netWorkWidget
            anchors.fill: parent
            color: UTheme.base
            radius: 8
            visible: false

            UNavigationBar {
                x: 10
                y:10
                width: 500
                height: 46
                model: [["西安","qrc:/icon/dark/success.svg"],["汉中","qrc:/icon/dark/info.svg"],
                    ["宝鸡","qrc:/icon/dark/waining.svg"], ["安康","qrc:/icon/dark/dark.svg"]]
            }

            UNavigationBar {
                x: 10
                y:80
                width: 500
                height: 46
                iconVisible: false
                buttonSize: Qt.size(60,30)
                model: [["西安","qrc:/icon/dark/success.svg"],["汉中","qrc:/icon/dark/info.svg"],
                    ["宝鸡","qrc:/icon/dark/waining.svg"], ["安康","qrc:/icon/dark/dark.svg"]]
            }

            UColorPicker {
                x: 10
                y: 140
                Component.onCompleted: {
                    open()
                }
            }

            UAvatar {
                x: 10
                y: 140
                width: 80
                height: 80
                source: "qrc:/image/button.svg"
            }

            ULinkButton {
                x: 10
                y: 340
                text: qsTr("ULinkButton")
            }
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
