import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.3
import utk.window 1.0
import "./framelesswindow"
import "./controls"

ApplicationWindow {
    property int itemCount: Math.floor((window.width - 10)/190)
    property int magins: 5
    property int contentMargins: 10
    property string appIcon: "qrc:/Union-2D.ico"
    property bool titleVisible: false
    id: window
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window;
    visible: true
    minimumWidth: 980
    minimumHeight: 680
    width: 1300
    height: 900
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
        anchors.margins: contentMargins
        radius: 10
        color: UTheme.window
    }

    UDialog {
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
            setMessage(message.arg(qmlHelper.colorName(UTheme.highlight)))
        }
    }

    UFloatingMessage {
        id: floatingMessage
        visible: false
        y: (window.height - floatingMessage.height) - 30
        maxWidth: window.width/3*2
    }

    UFramelessWindow {
        id: framelessWindow
        anchors.fill: parent
        anchors.margins: contentMargins
        parentObj: window
        menuButtonVisible: false

        Label {
            id: titleLabel
            x: framelessWindow.titleBar.x + 60
            anchors.verticalCenter: framelessWindow.titleBar.verticalCenter
            z: 10
            font.pixelSize: 15
            font.family: "Microsoft Yahei"
            text: window.title
            color: UTheme.text
        }

        URoundedButton {
            id: leftButton
            anchors.left: titleLabel.right
            anchors.leftMargin: 9
            anchors.verticalCenter: titleLabel.verticalCenter
            z: 10
            text: qsTr("Home")
            icon.source: "qrc:/icon/" + UTheme.themeName + "/left.svg"
            implicitWidth: 65
            implicitHeight: 35
            icon.width: 16
            icon.height: 16
            borderWidth: 1
            backgroundDefaultColor: "transparent"
            backgroundHoverdColor: Qt.darker(UTheme.informationBackground, 0.6)
            backgroundPressedColor : UTheme.informationBackground
            onClicked: {myLoader.sourceComponent = loginPage}
            enabled: myLoader.sourceComponent === mainPage
        }

        UButtonGroup {
            id: buttonGroup
            checkedIndex: UTheme.applicationTheme
            anchors.rightMargin: 165
            anchors.right: framelessWindow.titleBar.right
            anchors.verticalCenter: framelessWindow.titleBar.verticalCenter
            width: 80
            height: 40
            model: [["","qrc:/icon/" + UTheme.themeName + "/light.svg"],["","qrc:/icon/" + UTheme.themeName + "/dark.svg"]]
            onButtonClicked: {UTheme.applicationTheme = index}
        }

        UButton {
            id: languageButton
            anchors.rightMargin: 9
            anchors.right: buttonGroup.left
            anchors.verticalCenter: framelessWindow.titleBar.verticalCenter
            implicitWidth: 40
            implicitHeight: 40
            icon.source: (UTheme.applicationLanguage === 25) ? "qrc:/icon/" + UTheme.themeName + "/chinese.svg"
                                                             : "qrc:/icon/" + UTheme.themeName + "/english.svg"
            onClicked: {
                if (UTheme.applicationLanguage === 25) {
                    UTheme.applicationLanguage = 31
                } else {
                    UTheme.applicationLanguage = 25
                }
            }
        }

        UButton {
            anchors.rightMargin: 9
            anchors.right: languageButton.left
            anchors.verticalCenter: framelessWindow.titleBar.verticalCenter
            implicitWidth: 40
            implicitHeight: 40
            text: qsTr("关于")
            onClicked: {aboutDialog.open()}
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
            UGridView {
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

        floatingMessage.iconSource = isOk ? "qrc:/icon/" + UTheme.themeName + "/success.svg" : "qrc:/icon/" + UTheme.themeName + "/error.svg"
        floatingMessage.text = text
        floatingMessage.timeout = time
        floatingMessage.visible = true
    }
}
