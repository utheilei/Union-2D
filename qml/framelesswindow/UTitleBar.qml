import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import "../controls"
import "../"

ToolBar {
    leftPadding: 10
    property bool isMax: false
    property bool menuButtonVisible: true
    property bool minButtonVisible: true
    property bool maxButtonVisible: true
    property QtObject parentObj;
    property alias source: titleImage.source

    background: Rectangle {
        anchors.fill: parent
        color: UTheme.window
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
        onDoubleClicked: showWindow()
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
        UButton {
            id: menuButton
            visible: menuButtonVisible
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/" + UTheme.themeName + "/menu.svg"
            icon.width: 20
            icon.height: 20
            onClicked: barMenu.popup(menuButton.x + 20, menuButton.height + 10)
            ToolTip.text: qsTr("菜单")
        }
        UButton {
            visible: minButtonVisible
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/" + UTheme.themeName + "/hide.svg"
            icon.width: 20
            icon.height: 20
            onClicked: parentObj.showMinimized()
            ToolTip.text: qsTr("最小化")
        }
        UButton {
            visible: maxButtonVisible
            id: maxButton
            width: titleBar.height
            height: titleBar.height
            icon.source: "qrc:/icon/" + UTheme.themeName + "/max.svg"
            icon.width: 20
            icon.height: 20
            onClicked: showWindow()
            ToolTip.text: isMax ? qsTr("恢复") : qsTr("最大化")
        }
        UButton {
            width: titleBar.height
            height: titleBar.height
            hoverColor: "#FB4C3E"
            icon.source: "qrc:/icon/" + UTheme.themeName + "/close.svg"
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
        visible: parentObj.titleVisible
        anchors.centerIn: parent
        color: UTheme.text
    }

    function showWindow() {
        if (!isMax) {
            parentObj.contentMargins = 0
            parentObj.showFullScreen()
            maxButton.icon.source = "qrc:/icon/" + UTheme.themeName + "/min.svg"
        } else {
            parentObj.contentMargins = 10
            parentObj.showNormal()
            maxButton.icon.source = "qrc:/icon/" + UTheme.themeName + "/max.svg"
        }
        isMax = !isMax
    }
}
