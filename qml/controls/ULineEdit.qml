import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import "../"

TextField {
    id: field
    property bool isPassword: false
    property QtObject alertControl: control
    signal returnPressed

    width: 200
    height:  38
    placeholderText: qsTr("Please Input")
    selectByMouse : true
    rightPadding: closeButton.visible ? (closeButton.width + 20) : 10
    echoMode : isPassword ? TextInput.Password : TextInput.Normal
    clip:true
    opacity:field.enabled ? 1 : 0.5
    color: UTheme.text

    background: Rectangle {
        color: control.visible ? UTheme.errorBackground : UTheme.button
        radius: 10
        border.color: field.activeFocus ? UTheme.highlight : UTheme.button
        border.width: field.activeFocus? 1.5 : 0
    }

    onTextChanged: hideAlertMessage()

    URoundedButton {
        id: closeButton
        width: parent.height - 10
        height: parent.height - 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        visible: !(field.text === "")
        icon.source: "qrc:/icon/" + UTheme.themeName + "/close.svg"
        icon.width: closeButton.width/2
        icon.height: closeButton.height/2
        buttonRadius: width/2
        backgroundDefaultColor: UTheme.base

        onClicked: {
            field.clear()
            field.focus = true
        }
    }

    ToolTip {
        id: control
        visible: false
        timeout: 5000
        x: 0
        y: field.height + 2
        parent: field
        topPadding: 4
        bottomPadding: 4

        contentItem: Text {
            text: control.text
            font: control.font
            color: Qt.rgba(0.945, 0.224, 0.196, 1)
        }

        background: Rectangle {
            color: UTheme.base
            radius: 8
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 8.0
                samples: 17
                color: "#80000000"
            }
        }
    }

    Keys.onPressed: {
        switch(event.key) {
        case Qt.Key_Enter:
            if (field.activeFocus)
                returnPressed();
            break;
        case Qt.Key_Return:
            if (field.activeFocus)
                returnPressed();
            break;
        default :
            break;
        }
    }

    function setCloseButtonVisible(isVisible) {
        closeButton.visible = isVisible
    }

    function showAlertMessage(text, duration) {
        if (control.visible)
            return

        control.text = text
        control.timeout = duration
        control.visible = true
    }

    function hideAlertMessage() {
        if (control.visible) {
            control.visible = false
        }
    }
}
