import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Switch {
    id: control
    property color openBackgroudColor: UTheme.highlight
    property color closeBackgroudColor: UTheme.button

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: control.leftPadding
        y: parent.height / 2 - height / 2

        border.width: 0
        radius: 13
        color: control.checked ? openBackgroudColor : closeBackgroudColor

        //小圆点
        Rectangle {
            id : smallRect
            width: 26
            height: 26
            radius: 13
            color: control.down ? "#cccccc" : "#ffffff"
            border.color: "#999999"

            //改变小圆点的位置
            NumberAnimation on x{
                to: smallRect.width
                running: control.checked ? true : false
                duration: 200
            }

            //改变小圆点的位置
            NumberAnimation on x{
                to: 0
                running: control.checked ? false : true
                duration: 200
            }
        }
    }
}
