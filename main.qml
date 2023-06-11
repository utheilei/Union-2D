import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.3
import "./FramelessWindow"
import "./controls"

ApplicationWindow {
    property color tingeColor: Qt.rgba(255, 255, 255, 0.9)
    property int itemCount: Math.floor((window.width - 10)/190)
    property int magins: 5
    property string appIcon: "qrc:/Union-2D.ico"
    id: window
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window;
    visible: true
    minimumWidth: 500
    minimumHeight: 300
    width: 970
    height: 670
    title: qsTr("Union-2D")
    x: Screen.width/2 - width/2
    y: Screen.height/2 - height/2

    SystemPalette {
        id: windowPalette
    }

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
        color: tingeColor
    }

    HLMenu {
        id: barMenu
        HLMenu {
            title: qsTr("theme")
            HLMenuItem {
                id: lightItem
                text: "light"
                checkable: true
                checked: true
                onTriggered: {checked = true;darkItem.checked = false}
            }
            HLMenuItem {
                id: darkItem
                text: "dark"
                checkable: true
                checked: false
                onTriggered: {checked = true;lightItem.checked = false}
            }
        }
        HLMenuItem {
            text: qsTr("about")
            onTriggered: aboutDialog.open()
        }
        MenuSeparator {
        }
        HLMenuItem {
            text: qsTr("exit")
            onTriggered: Qt.quit()
        }
    }

    HLDialog {
        id: aboutDialog
        Component.onCompleted: {
            setIcon(appIcon)
            setTitle(qsTr("about"))
            setContentTitle(qsTr("qml实现统一的通用控件库"))
            setMessage(qsTr("https://gitee.com/uthelei/Union-2D"))
        }
    }

    FramelessWindow {
        id: framelessWindow
        anchors.fill: parent
        anchors.margins: 10
        parentObj: window

        HLRoundedButton {
            id: leftButton
            x: framelessWindow.titleBar.x + 60
            y: 7.5
            icon.source: "qrc:/icon/left.svg"
            implicitWidth: 35
            implicitHeight: 35
            visible: myLoader.sourceComponent === mainPage
            onClicked: myLoader.sourceComponent = loginPage
        }

        Loader {
            id: myLoader
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: magins
            anchors.right: parent.right
            anchors.rightMargin: magins
            anchors.bottom: parent.bottom
            anchors.bottomMargin: magins
            sourceComponent: loginPage
        }

        Component {
            id: loginPage
            HLGridView {
                id: scrollView
                count: itemCount
                parentObj: window
                model: qmlHelper.listModel()
                paddings: (window.width - itemCount*itemWidth - (itemCount-1)*20 - 28)/2
                ScrollBar.horizontal: ScrollBar{visible: false}
                onIconItemClicked: {
                    console.info("HLIconItem Clicked Index=", index, count)
                    myLoader.sourceComponent = mainPage
                    myLoader.item.setCurrentItem(index)
                }
            }
        }

        Component {
            id: mainPage
            QmlMainWidget {
                id: qmlMainWidget
                clip: true
            }
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: rect
        }
    }
}
