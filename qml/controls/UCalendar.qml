import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "../"

Old.Calendar {
    property date currentDate: new Date()
    id: calendar
    frameVisible: false
    selectedDate: currentDate
    dayOfWeekFormat: Locale.ShortFormat
    style: CalendarStyle {
        gridVisible: false
        background: URoundedRectangle {
            color: UTheme.base
            radius: 8
            implicitWidth: 300
            implicitHeight: 300
        }
        navigationBar: Rectangle{
            height: control.height/8;
            color: UTheme.base
            Text{
                id:dateText;
                anchors.centerIn: parent;
                color: UTheme.text
                font{family: "Microsoft YaHei"; pixelSize:14}
                text:{
                    var str=control.visibleYear+"年"+fillZero(control.visibleMonth+1)+"月";
                    return str;
                }
            }
            UButton {
                id:previousMonth;
                anchors.right: dateText.left;
                anchors.rightMargin: 20;
                anchors.verticalCenter: dateText.verticalCenter;
                width: 20
                height: 20
                icon.width: 16
                icon.height: 16
                icon.source: (UTheme.applicationTheme === 0) ? "qrc:/icon/light/left.svg" : "qrc:/icon/dark/left.svg"
                onClicked: {
                    control.showPreviousMonth();
                }
            }
            UButton {
                id:previousYear;
                anchors.right: previousMonth.left;
                anchors.rightMargin: 10;
                anchors.verticalCenter: dateText.verticalCenter;
                width: 20
                height: 20
                icon.width: 16
                icon.height: 16
                icon.source: (UTheme.applicationTheme === 0) ? "qrc:/icon/light/leftarrow.svg" : "qrc:/icon/dark/leftarrow.svg"
                onClicked: {
                    control.showPreviousYear();
                }
            }
            UButton {
                id:nextMonth;
                anchors.left: dateText.right;
                anchors.leftMargin: 20;
                anchors.verticalCenter: dateText.verticalCenter;
                width: 20
                height: 20
                icon.width: 16
                icon.height: 16
                icon.source: (UTheme.applicationTheme === 0) ? "qrc:/icon/light/right.svg" : "qrc:/icon/dark/right.svg"
                onClicked: {
                    control.showNextMonth();
                }
            }
            UButton {
                id:nextYear;
                anchors.left: nextMonth.right;
                anchors.leftMargin: 10;
                anchors.verticalCenter: dateText.verticalCenter;
                width: 20
                height: 20
                icon.width: 16
                icon.height: 16
                icon.source: (UTheme.applicationTheme === 0) ? "qrc:/icon/light/rightarrow.svg" : "qrc:/icon/dark/rightarrow.svg"
                onClicked: {
                    control.showNextYear();
                }
            }
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: 1
                width: parent.width
                color: UTheme.buttonText
            }
            //长度不足2 补零
            function fillZero(value) {
                return value.toString().length < 2 ? ('0' + value) : value
            }
        }
        dayDelegate: Rectangle {
            color: UTheme.base
            Rectangle {
                anchors.centerIn: parent
                antialiasing: true
                width: Math.min(parent.width, parent.height) - 4
                height: Math.min(parent.width, parent.height) - 4
                color: styleData.selected ? UTheme.highlight : "transparent"
                radius: height
                border.color: UTheme.highlight
                border.width: (control.equalDate(styleData.date, control.currentDate)) ? 1 : 0
            }
            Label {
                text: styleData.date.getDate()
                anchors.centerIn: parent
                color: UTheme.text
                opacity: styleData.visibleMonth ? 1 : 0.3
            }
        }

        dayOfWeekDelegate : Rectangle {
            height: control.height/8
            color: UTheme.base
            Label {
                text: qmlHelper.dayOfWeek(styleData.index, control.dayOfWeekFormat)
                anchors.centerIn: parent
                color: UTheme.text
                font.bold: true
            }
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: 1
                width: parent.width
                color: UTheme.buttonText
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
