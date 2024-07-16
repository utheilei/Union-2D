import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

ToolTip {
    id: control
    timeout: -1
    height: 45
    width: iconSource.width + contentText.width + 35
    closePolicy: Popup.NoAutoClose

    enum AlertType {
        Success,
        Message,
        Waining,
        Error
    }

    property var alertType: UAlert.AlertType.Success
    property color alertColor: UTheme.successBackground
    property int toolTipRadius: 8
    property size iconSize: Qt.size(30, 30)
    property int maxWidth

    contentItem: Item {
        Row {
            id: rowLayout
            anchors.fill: parent
            leftPadding: 5
            rightPadding: 10
            spacing: 10
            Image {
                id: iconSource
                width: iconSize.width
                height: iconSize.height
                fillMode: Image.PreserveAspectFit
                sourceSize: iconSize
                source: control.iconSource(UTheme.themeName, alertType)
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: contentText
                width: fontMetrics.boundingRect(control.text).width > maxWidth ? maxWidth : fontMetrics.boundingRect(control.text).width
                anchors.verticalCenter: parent.verticalCenter
                text: control.text
                font: control.font
                color: alertColor
                opacity: control.enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: fontMetrics.boundingRect(control.text).width > maxWidth ? Text.ElideRight : Text.ElideNone
            }

            FontMetrics {
                id: fontMetrics
                font: control.font
            }
        }
    }

    background: Rectangle {
        color: qmlHelper.colorAlpha(alertColor, 30)
        border.width: 1
        border.color: alertColor
        radius: toolTipRadius
        antialiasing: true
    }

    function iconSource(themeName, type) {
        switch(type) {
        case UAlert.AlertType.Success:
            return "qrc:/icon/" + themeName + "/success.svg"
        case UAlert.AlertType.Message:
            return "qrc:/icon/" + themeName + "/info.svg"
        case UAlert.AlertType.Waining:
            return "qrc:/icon/" + themeName + "/waining.svg"
        default:
            return "qrc:/icon/" + themeName + "/error.svg"
        }
    }
}
