import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.3
import an.window 1.0
import "./FramelessWindow"
import "./controls"

ApplicationWindow {
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
        color: HLTheme.window

        Behavior on color {
            ColorAnimation {
                duration: 1000
            }
        }
    }

    HLMenu {
        id: barMenu
        HLMenu {
            title: qsTr("theme")
            HLMenuItem {
                id: lightItem
                text: qsTr("light")
                checkable: true
                checked: true
                onTriggered: {checked = true;darkItem.checked = false; HLTheme.theme = 0}
            }
            HLMenuItem {
                id: darkItem
                text: qsTr("dark")
                checkable: true
                checked: false
                onTriggered: {checked = true;lightItem.checked = false; HLTheme.theme = 1}
            }
        }
        HLMenu {
            title: qsTr("translation")
            HLMenuItem {
                id: chineseItem
                text: qsTr("Chinese")
                checkable: true
                checked: true
                onTriggered: {checked = true;englishItem.checked = false; qmlHelper.setTranslator(25)}
            }
            HLMenuItem {
                id: englishItem
                text: qsTr("English")
                checkable: true
                checked: false
                onTriggered: {checked = true;chineseItem.checked = false; qmlHelper.setTranslator(31)}
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
            initUi()
            qmlHelper.languageChanged.connect(initUi)
            var test = "I am %1 years old."
            console.log(test.arg(10))
        }
        function initUi() {
            setIcon(appIcon)
            setTitle(qsTr("about"))
            setContentTitle(qsTr("qml实现统一的通用控件库"))
            var message = "<a style='text-decoration:none;color: %1;' href=\"https://gitee.com/uthelei/Union-2D\">https://gitee.com/uthelei/Union-2D";
            setMessage(message.arg(qmlHelper.colorName(HLTheme.highlight)))
        }
    }

    HLFloatingMessage {
        id: floatingMessage
        visible: false
        y: (window.height - floatingMessage.height) - 30
        maxWidth: window.width/3*2
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
            z: 10
            icon.source: (HLTheme.theme === 0) ? "qrc:/icon/light/left.svg" : "qrc:/icon/dark/left.svg"
            implicitWidth: 35
            implicitHeight: 35
            icon.width: 16
            icon.height: 16
            visible: (myLoader.sourceComponent === mainPage)
            onClicked: {myLoader.sourceComponent = loginPage}
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

    function showFloatingMessage(isOk, text, time) {
        if (floatingMessage.visible)
            return

        floatingMessage.iconSource = isOk ? "qrc:/icon/yes.svg" : "qrc:/icon/error.svg"
        floatingMessage.text = text
        floatingMessage.timeout = time
        floatingMessage.visible = true
    }
}
