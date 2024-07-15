import QtQuick 2.7
import QtQuick.Controls 2.4

Row {
    id: rowLayout
    enum BarType {
        TextRight,
        TextCenter
    }

    property var type: UProgressBar.BarType.TextRight
    property int percent: 50
    property color foreground: UTheme.successBackground
    property color background: UTheme.button
    property color textColor: UTheme.text
    spacing: 5
    Rectangle {
        width: 200
        height: 20
        radius: height / 2
        color: background
        anchors.verticalCenter: parent.verticalCenter
        Rectangle {
            width: (percent > 100) ? parent.width : percent / 100 * parent.width
            height: parent.height
            radius: parent.radius
            color: foreground
        }

        Text {
            anchors.centerIn: parent
            text: percent + "%"
            color: textColor
            opacity: enabled ? 1.0 : 0.3
            visible: type === UProgressBar.BarType.TextCenter
        }
    }

    Text {
        text: percent + "%"
        color: textColor
        opacity: enabled ? 1.0 : 0.3
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: type === UProgressBar.BarType.TextRight
    }
}

