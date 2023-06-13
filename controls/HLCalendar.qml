import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Old.Calendar {
    property date currentDate: new Date()
    id: calendar
    frameVisible: false
    selectedDate: currentDate
    dayOfWeekFormat: Locale.ShortFormat
    style: CalendarStyle {
        gridVisible: false
        background: HLRoundedRectangle {
            color: "white"
            radius: 8
            implicitWidth: 300
            implicitHeight: 300
        }
        navigationBar: Rectangle{
            height: control.height/8;
            color: "white";
            Text{
                id:dateText;
                anchors.centerIn: parent;
                color: "black";
                font{family: "Microsoft YaHei"; pixelSize:14}
                text:{
                    var str=control.visibleYear+"年"+fillZero(control.visibleMonth+1)+"月";
                    return str;
                }
            }
            Button {
                id:previousMonth;
                anchors.right: dateText.left;
                anchors.rightMargin: 20;
                anchors.verticalCenter: dateText.verticalCenter;
                icon.width: 16
                icon.height: 16
                icon.source: "qrc:/icon/left.svg"
                background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: previousMonth.down ? Qt.darker("#f0f0f0", 1.1) : (previousMonth.hovered ? "#f0f0f0" : "transparent")
                }
                onClicked: {
                    control.showPreviousMonth();
                }
            }
            Button {
                id:previousYear;
                anchors.right: previousMonth.left;
                anchors.rightMargin: 10;
                anchors.verticalCenter: dateText.verticalCenter;
                icon.width: 16
                icon.height: 16
                icon.source: "qrc:/icon/leftarrow.svg"
                background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: previousYear.down ? Qt.darker("#f0f0f0", 1.1) : (previousYear.hovered ? "#f0f0f0" : "transparent")
                }
                onClicked: {
                    control.showPreviousYear();
                }
            }
            Button {
                id:nextMonth;
                anchors.left: dateText.right;
                anchors.leftMargin: 20;
                anchors.verticalCenter: dateText.verticalCenter;
                icon.width: 16
                icon.height: 16
                icon.source: "qrc:/icon/right.svg"
                background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: nextMonth.down ? Qt.darker("#f0f0f0", 1.1) : (nextMonth.hovered ? "#f0f0f0" : "transparent")
                }
                onClicked: {
                    control.showNextMonth();
                }
            }
            Button {
                id:nextYear;
                anchors.left: nextMonth.right;
                anchors.leftMargin: 10;
                anchors.verticalCenter: dateText.verticalCenter;
                icon.width: 16
                icon.height: 16
                icon.source: "qrc:/icon/rightarrow.svg"
                background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 8
                    color: nextYear.down ? Qt.darker("#f0f0f0", 1.1) : (nextYear.hovered ? "#f0f0f0" : "transparent")
                }
                onClicked: {
                    control.showNextYear();
                }
            }
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: 1
                width: parent.width
                color: "black"
            }
            //长度不足2 补零
            function fillZero(value) {
                return value.toString().length < 2 ? ('0' + value) : value
            }
        }
        dayDelegate: Rectangle {
            color: "white"
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
                color: styleData.visibleMonth ? "black" : Qt.rgba(0,0,0,0.3)
            }
        }

        dayOfWeekDelegate : Rectangle {
            height: control.height/8
            color: "white"
            Label {
                text: qmlHelper.dayOfWeek(styleData.index, control.dayOfWeekFormat)
                anchors.centerIn: parent
                color: "black"
                font.bold: true
            }
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: 1
                width: parent.width
                color: "black"
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
