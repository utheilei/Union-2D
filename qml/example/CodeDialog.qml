import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import "../controls"
import utk.component 1.0

Popup {
    id: modalDialog

    property string icon: "qrc:/Union-2D.ico"
    property string title: qsTr("效果演示")

    signal accepted
    signal rejected

    closePolicy: Popup.NoAutoClose
    modal: true
    dim: false
    x: parent.width/2-width/2
    y: parent.height/2-height/2
    width: 505
    height: 605
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
        color: UTheme.window
    }

    background: Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        anchors.margins: 10
        color: UTheme.window
        radius: 10
        border.width: 0
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
                color: UTheme.text
                horizontalAlignment: Qt.AlignCenter
            }

            UButton {
                id: closeButton
                implicitWidth: 49.5
                implicitHeight: 49.5
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 0
                hoverColor: "#FB4C3E"
                buttonPosition: URadiusRectangle.ItemPosition.TopLeft | URadiusRectangle.ItemPosition.BottomLeft | URadiusRectangle.ItemPosition.BottomRight
                icon.source: "qrc:/icon/" + UTheme.themeName + "/close.svg"
                onClicked: {modalDialog.rejected();modalDialog.close()}
            }
        }
    }

    ColumnLayout {
        id: contentLayout
        spacing: 10
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.right: parent.right
        height: 505

        Item {
            id: titleItem
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            width: 158
            height: 64
        }

        ScrollView {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            width: 470
            clip: true
            TextArea {
                id: textArea
                width: 470
                textMargin: 16
                color: UTheme.text
                text: componentLoader.loadFile(qmlHelper.appPath() + "/codedemo/URoundedButton.qml")
                wrapMode: TextEdit.WordWrap
                selectByMouse: true
                Component.onCompleted: {
                    componentLoader.setData(textArea.text)
                }
            }
            background: Rectangle {
                border.color: UTheme.button
                color: "transparent"
                radius: 8
            }
        }

        URoundedButton {
            id: confirmButton
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            backgroundDefaultColor: "transparent"
            backgroundHoverdColor: UTheme.highlight
            backgroundPressedColor: Qt.darker(UTheme.highlight, 1.4)
            textColor: UTheme.highlight
            textHoverdColor: UTheme.highlightedText
            textPressedColor: UTheme.highlightedText
            borderWidth: 1
            borderColor: UTheme.highlight
            borderHoverdColor: UTheme.highlight
            implicitWidth: 180
            implicitHeight: 40
            text: qsTr("预览")
            onClicked: {
                componentLoader.setData(textArea.text)
            }
        }
    }
    ComponentLoader {
        id: componentLoader
    }

    Connections {
        target: componentLoader
        function onComponentChanged() {
            var obj = componentLoader.create(titleItem)
            obj.parent = titleItem
            obj.x = (titleItem.width - obj.width)/2
        }
    }
}
