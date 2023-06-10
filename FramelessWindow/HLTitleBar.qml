import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import "../controls"

ToolBar {
    leftPadding: 10
    property bool isMax: false
    property QtObject parentObj;
    property alias source: titleImage.source

    background: Rectangle {
        anchors.fill: parent
        color: "#ffffff"
        layer.enabled: true
        layer.effect: DropShadow {
            color: "#000000"
        }
    }

    MouseArea {
        property real xmouse;   //鼠标的x轴坐标
        property real ymouse;   //y轴坐标
        anchors.fill: parent
        onPressed: {
            xmouse=mouse.x;
            ymouse=mouse.y;
        }

        onPositionChanged: {
            parentObj.x=parentObj.x+(mouse.x-xmouse);
            parentObj.y=parentObj.y+(mouse.y-ymouse);
        }
    }

    RowLayout {
        anchors.fill: parent
        Image {
            id: titleImage
            sourceSize: Qt.size(40, 40)
        }
        Rectangle {
            id: contentRectangle
            Layout.fillWidth: true
        }
        HLButton {
            id: menuButton
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/menu.svg"
            icon.width: 20
            icon.height: 20
            onClicked: barMenu.popup(menuButton.x + 20, menuButton.height + 10)
        }
        HLButton {
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/hide.svg"
            icon.width: 20
            icon.height: 20
            onClicked: parentObj.showMinimized()
        }
        HLButton {
            id: maxButton
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/max.svg"
            icon.width: 20
            icon.height: 20
            onClicked: showWindow()
        }
        HLButton {
            width: titleBar.height
            height: titleBar.height
            hoverColor: "#FB4C3E"
            icon.source: "qrc:/icon/close.svg"
            icon.width: 20
            icon.height: 20
            onClicked: Qt.quit()
        }
    }

    Label {
        id: name
        font.pixelSize: 15
        font.family: "Microsoft Yahei"
        text: parentObj.title
        anchors.centerIn: parent
    }

    function showWindow() {
        if (!isMax) {
            parentObj.showFullScreen()
            maxButton.icon.source = "qrc:/icon/min.svg"
        } else {
            parentObj.showNormal()
            maxButton.icon.source = "qrc:/icon/max.svg"
        }
        isMax = !isMax
    }
}
