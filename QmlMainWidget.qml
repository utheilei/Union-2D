import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
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
            Old.Calendar {
                property date currentDate: new Date()
                id: calendar
                frameVisible: false
                anchors.centerIn: parent
                selectedDate: currentDate
                dayOfWeekFormat: Locale.ShortFormat
                style: CalendarStyle {
                    gridVisible: false
                    background: HLRoundedRectangle {
                        color: "black"
                        radius: 8
                        implicitWidth: 300
                        implicitHeight: 300
                    }
                    navigationBar: Rectangle{
                        height: control.height/8;
                        color: "black";
                        Text{
                            id:dateText;
                            anchors.centerIn: parent;
                            color: "#333333";
                            font{family: "Microsoft YaHei"; pixelSize: 14;}
                            text:{
                                var str=control.visibleYear+"年"+fillZero(control.visibleMonth+1)+"月";
                                return str;
                            }
                        }
                        HLRoundedButton {
                            id:previousMonth;
                            anchors.right: dateText.left;
                            anchors.rightMargin: 20;
                            anchors.verticalCenter: dateText.verticalCenter;
                            icon.width: 16
                            icon.height: 16
                            icon.source: "qrc:/icon/left.svg"
                            onClicked: {
                                control.showPreviousMonth();
                            }
                        }
                        HLRoundedButton {
                            id:nextMonth;
                            anchors.left: dateText.right;
                            anchors.leftMargin: 20;
                            anchors.verticalCenter: dateText.verticalCenter;
                            icon.width: 16
                            icon.height: 16
                            icon.source: "qrc:/icon/right.svg"
                            onClicked: {
                                control.showNextMonth();
                            }
                        }
                        //长度不足2 补零
                        function fillZero(value) {
                            return value.toString().length < 2 ? ('0' + value) : value
                        }
                    }
                    dayDelegate: Rectangle {
                        color: "black"
                        Rectangle {
                            anchors.centerIn: parent
                            antialiasing: true
                            width: Math.min(parent.width, parent.height) - 4
                            height: Math.min(parent.width, parent.height) - 4
                            color: styleData.selected ? "#03A9F4" : "transparent"
                            radius: height
                            border.color: "#03A9F4"
                            border.width: (control.equalDate(styleData.date, control.currentDate)) ? 1 : 0
                        }
                        Label {
                            text: styleData.date.getDate()
                            anchors.centerIn: parent
                            color: styleData.visibleMonth ? "white" : "grey"
                        }
                    }

                    dayOfWeekDelegate : Rectangle {
                        height: control.height/8
                        color: "black"
                        Label {
                            text: qmlHelper.dayOfWeek(styleData.index, control.dayOfWeekFormat)
                            anchors.centerIn: parent
                            color: "white"
                            font.bold: true
                        }
                    }
                }

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: calendar.width
                        height: calendar.height
                        radius: 8
                    }
                }
                function equalDate(date, otherDate) {
                    return date.toLocaleDateString() === otherDate.toLocaleDateString()
                }
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
