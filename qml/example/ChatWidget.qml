import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import utk.window 1.0
import "../controls"
import "qrc:/qml/js/XMLHttpRequest.js" as HttpClient

Item {
    Label {
        id: titleLabel
        anchors.top: parent.top
        anchors.left: parent.left
        font.pixelSize: 20
        font.bold: true
        color: UTheme.text
        text: qsTr("机器人-小U")
    }

    UListView {
        id: listView
        anchors.top: titleLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        width: parent.width - 30
        height: parent.height / 3 * 2
        spacing: 15
        model: listModel
        delegate: listDelegate
        highlightFollowsCurrentItem: false
        onModelChanged: listView.positionViewAtEnd();

        Component.onCompleted: listModel.clear()
    }

    Item {
        id: middleBar
        width: parent.width
        height: 40
        anchors.top: listView.bottom
        anchors.left: parent.left

        Row {
            anchors.centerIn: parent
            spacing: 30
            Repeater {
                model: ["qrc:/image/font.svg",
                    "qrc:/image/fontcolor.svg",
                    "qrc:/image/expression.svg"]
                UButton {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 30
                    icon.source: modelData

                    onClicked: buttonClicked(index)
                }
            }
        }
    }

    UTextArea {
        id: inputTextArea
        anchors.top: middleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        background: Rectangle {
            radius: 8
            color: UTheme.button
        }

        function sendMessage(isPeer) {
            if (inputTextArea.length === 0) {
                control.text = qsTr("消息内容不能为空！")
                control.visible = true
                return
            }
            listModel.append({"roles": isPeer, "messages":inputTextArea.text})
            var res = qmlHelper.removeSpecialCharacters(inputTextArea.toPlainText())
            if (res.trim().length === 0)
            {
                res = "你好"
            }
            var data = {"body": res}
            HttpClient.postRequestAsync("http://localhost:8000/api/v1/chatrobot", JSON.stringify(data), successCallback, errorCallback)
            inputTextArea.clearText()
        }
    }

    URoundedButton {
        id: sendButton
        width: 80
        height: 30
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        backgroundDefaultColor: UTheme.highlight
        textColor: UTheme.highlightedText
        text: qsTr("发送")
        onClicked: inputTextArea.sendMessage(false)
    }

    ToolTip {
        id: control
        visible: false
        timeout: 3000
        parent: sendButton
        padding: 5

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

    Component {
        id: listDelegate
        Item {
            width: listView.width
            height: hlTextArea.contentHeight + 10
            Row {
                anchors.fill: parent
                layoutDirection: roles ? Qt.LeftToRight : Qt.RightToLeft
                spacing: 10

                AnimatedImage {
                    id: animatedImage
                    playing: true
                    width: 40
                    height: 40
                    mipmap: true
                    source: roles ? "qrc:/image/woman.svg" : "qrc:/image/man.svg"
                    anchors.verticalCenter: parent.verticalCenter
                }

                UTextArea {
                    id: hlTextArea
                    text: messages
                    readOnly: true
                    maximumWidth: listView.width - 120
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle {
                        radius: 8
                        color: roles ? UTheme.base : UTheme.highlight
                    }
                }
            }
        }
    }

    ListModel {
        id: listModel
        ListElement { roles: true; messages: "#E4E4E4";}
    }

    FontDialog {
        id: fontDialog
        currentFont.family: inputTextArea.font
        visible: false
        onAccepted: inputTextArea.font = fontDialog.currentFont
    }

    UColorPicker {
        id: colorDialog
        initColor: inputTextArea.color
        onAccepted: inputTextArea.color = colorDialog.currentColor
    }

    ScrollView {
        id: scrollView
        padding: 10
        width: 300
        height: 200
        anchors.bottom: middleBar.top
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        visible: false
        background: Rectangle {
            radius: 10
            color: UTheme.alternateBase
        }
        Grid {
            anchors.fill: parent
            rowSpacing: 8
            columnSpacing: 8
            columns: Math.floor(scrollView.width/50)

            Repeater {
                model: 111
                AnimatedImage {
                    playing: true
                    width: 40
                    height: 40
                    mipmap: true
                    source: "qrc:/icon/wxFace/" + (index + 1) + ".gif"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            inputTextArea.insertQuickImage(source)
                            scrollView.visible = false
                        }
                    }
                }
            }
        }
    }

    function buttonClicked(index) {
        switch(index) {
        case 0:
            fontDialog.open()
            break
        case 1:
            colorDialog.open()
            break
        case 2:
            scrollView.visible = !scrollView.visible
            break
        default:
            break
        }
    }

    function successCallback(response) {
        var jsonObject = JSON.parse(response["content"]);
        listModel.append({"roles": true, "messages": jsonObject["result"]})
    }

    function errorCallback(response) {
        console.error(response)
    }
}
