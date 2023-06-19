import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import "../"

Popup {
    id: modalDialog

    property string icon
    property color btnColor: "transparent"
    property string title
    property string clickBtnText

    signal accepted
    signal rejected

    closePolicy: Popup.NoAutoClose
    modal: true
    dim: false
    x: parent.width/2-width/2
    y: parent.height/2-height/2
    width: 420
    height: titleBar.height + contentLayout.height
    padding: 0
    margins: 0
    clip: true

    RectangularGlow {
        id: effect
        anchors.fill: rect
        glowRadius: 5
        spread: 0.2
        color: "black"
        cornerRadius: rect.radius + glowRadius
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.margins: 10
        radius: 10
        color: windowTheme.window
    }

    background: Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        anchors.margins: 10
        color: windowTheme.window
        radius: 10
        border.width: 0
    }

    ListModel {
        /* 数据项 */
        id: myModel
        ListElement { name: qsTr("Cancle"); btnColor: "#E5E5E5"; }
        ListElement { name: qsTr("Ok"); btnColor: "#0081FF"; }
    }

    Rectangle {
        id: titleBar
        width: parent.width - 20
        height: 50
        color: "transparent"
        radius: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            property real xmouse;   //鼠标的x轴坐标
            property real ymouse;   //y轴坐标
            anchors.fill: parent
            onPressed: {
                xmouse=mouse.x;
                ymouse=mouse.y;
            }

            onPositionChanged: {
                modalDialog.x = modalDialog.x + (mouse.x-xmouse);
                modalDialog.y = modalDialog.y + (mouse.y-ymouse);
            }
        }

        RowLayout {
            anchors.fill: parent
            Image {
                id: dialogIcon
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 10
                width: 32
                height: 32
                source: modalDialog.icon
                sourceSize: Qt.size(32, 32)
            }

            Text {
                id: dialogTitle
                text: modalDialog.title
                Layout.alignment: Qt.AlignCenter
                wrapMode : Text.WordWrap
                font.pixelSize: 15
                font.family: "Microsoft Yahei"
                color: windowTheme.text
                horizontalAlignment: Qt.AlignCenter
            }

            HLButton {
                id: closeButton
                implicitWidth: 49.5
                implicitHeight: 49.5
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 0
                hoverColor: "#FB4C3E"
                buttonPosition: 3
                icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/close.svg" : "qrc:/icon/dark/close.svg"
                onClicked: modalDialog.close()
            }
        }
    }

    ColumnLayout {
        id: contentLayout
        anchors.top: titleBar.bottom
        anchors.margins: 10
        spacing: 20
        width: parent.width
        height: titleLabel.contentHeight + messageLabel.contentHeight + 80 + 40

        Label {
            id: titleLabel
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            font.pixelSize: 22
            font.italic: true
            wrapMode : Text.WordWrap
            visible: false
            color: windowTheme.text
            Layout.maximumWidth: modalDialog.width - 10
            horizontalAlignment: Qt.AlignHCenter
        }

        Label {
            id: messageLabel
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            wrapMode : Text.WordWrap
            visible: false
            color: windowTheme.text
            Layout.maximumWidth: modalDialog.width - 10
            horizontalAlignment: Qt.AlignHCenter
        }

        Row {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            spacing: 10
            Layout.fillHeight: true
            Repeater {
                model: myModel
                Button {
                    implicitWidth: 180
                    implicitHeight: 40
                    hoverEnabled: true
                    text: name

                    background: Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: parent.height
                        radius: 10
                        color: btnColor
                        border.width: 1
                        border.color: windowTheme.frameBorder
                    }

                    onClicked: {
                        buttonClicked(text)
                        modalDialog.close()
                    }

                    onHoveredChanged: {
                        background.color = hovered ? Qt.darker(btnColor, 1.1) : btnColor
                    }
                }
            }
        }
    }

    function buttonClicked(text) {
        clickBtnText = text
        switch (text) {
        case myModel.get(0).name:
            modalDialog.rejected()
            break;
        case myModel.get(1).name:
            modalDialog.accepted()
            break;
        default:
            break;
        }
    }

    function setIcon(icon) {
        modalDialog.icon = icon
    }

    function setTitle(title) {
        modalDialog.title = title
    }

    function setContentTitle(text) {
        titleLabel.text = text
        titleLabel.visible = true
    }

    function setMessage(text) {
        messageLabel.text = text
        messageLabel.visible = true
    }
}
