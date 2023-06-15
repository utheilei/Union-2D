import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import "../"

ListView {
    id: view
    property int itemHeight: 46
    property int itemRadius: 10
    property bool iconVisible: false
    property bool buttonVisible: false
    property color itemColor: windowTheme.itemBackgroud
    signal hoverChanged(var isHovered)

    spacing: 5
    delegate: listDelegate

    Component {
        id: listDelegate
        Rectangle {
            property bool isEnter: false
            id: itemRectangle
            width: view.width - leftMargin - rightMargin
            height: itemHeight
            radius: itemRadius
            color: view.currentIndex === index ? windowTheme.highlight :
                                                 (isEnter ? windowTheme.button : itemColor)
            Image {
                id: iconItem
                anchors.left: parent.left
                anchors.leftMargin: iconVisible ? 10 : 0
                anchors.verticalCenter: parent.verticalCenter
                source: modelData[1]
                sourceSize: Qt.size(35, 35)
                visible: iconVisible
                width: iconVisible ? sourceSize.width : 0
                height: iconVisible ? sourceSize.height : 0
            }

            Text {
                id: itemText
                anchors.left: iconItem.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: (parent.width - iconItem.width - closeButton.width - 20 -
                        (iconItem.visible ? 10 : 0) - (closeButton.visible ? 10 : 0))
                text: modelData[0]
                color: view.currentIndex === index ? windowTheme.highlightedText : windowTheme.text
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

            HLRoundedButton {
                id: closeButton
                width: visible ? 30 : 0
                height: visible ? 30 : 0
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                visible: false
                icon.source: (windowTheme.theme == 0) ? "qrc:/icon/light/close.svg" : "qrc:/icon/dark/close.svg"
                buttonRadius: 15
                backgroundDefaultColor: windowTheme.base

                onClicked: {
                    console.info(index)
                    listModel.remove(index)
                }
            }

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: {view.focus = true; view.currentIndex = index; mouse.accepted = false}
                onEntered: {
                    isEnter = true
                    if (buttonVisible)
                        closeButton.visible = true
                    hoverChanged(true)
                }
                onExited: {
                    isEnter = false
                    if (buttonVisible)
                        closeButton.visible = false
                }
            }
        }
    }

    Keys.enabled: true;
    Keys.onPressed: {
        switch(event.key) {
        case Qt.Key_Up:
            if (view.currentIndex <= 0)
                return
            view.currentIndex = view.currentIndex - 1
            break;
        case Qt.Key_Down:
            if (view.currentIndex >= view.count - 1)
                return
            view.currentIndex = view.currentIndex + 1
            break;
        default:
            return;
        }
        event.accepted = true;
    }
}

