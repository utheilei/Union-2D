import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import "../controls"
import "../"

ToolBar {
    leftPadding: 10
    property bool isMax: false
    property QtObject parentObj;
    property alias source: titleImage.source

    background: Rectangle {
        anchors.fill: parent
        color: windowTheme.window
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
            icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/menu.svg" : "qrc:/icon/dark/menu.svg"
            icon.width: 20
            icon.height: 20
            onClicked: barMenu.popup(menuButton.x + 20, menuButton.height + 10)
            ToolTip.text: qsTr("菜单")
        }
        HLButton {
            width: titleBar.height
            height: titleBar.height
            icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/hide.svg" : "qrc:/icon/dark/hide.svg"
            icon.width: 20
            icon.height: 20
            onClicked: parentObj.showMinimized()
            ToolTip.text: qsTr("最小化")
        }
        HLButton {
            id: maxButton
            width: titleBar.height
            height: titleBar.height
            icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/max.svg" : "qrc:/icon/dark/max.svg"
            icon.width: 20
            icon.height: 20
            onClicked: showWindow()
            ToolTip.text: isMax ? qsTr("恢复") : qsTr("最大化")
        }
        HLButton {
            width: titleBar.height
            height: titleBar.height
            hoverColor: "#FB4C3E"
            icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/close.svg" : "qrc:/icon/dark/close.svg"
            icon.width: 20
            icon.height: 20
            ToolTip.text: qsTr("关闭")
            onClicked: parentObj.close()
        }
    }

    Label {
        id: name
        font.pixelSize: 15
        font.family: "Microsoft Yahei"
        text: parentObj.title
        anchors.centerIn: parent
        color: windowTheme.text
    }

    function showWindow() {
        if (!isMax) {
            parentObj.showFullScreen()
            maxButton.icon.source = (windowTheme.theme == 0) ? "qrc:/icon/light/min.svg" : "qrc:/icon/dark/min.svg"
        } else {
            parentObj.showNormal()
            maxButton.icon.source = (windowTheme.theme == 0) ? "qrc:/icon/light/max.svg" : "qrc:/icon/dark/max.svg"
        }
        isMax = !isMax
    }
}
