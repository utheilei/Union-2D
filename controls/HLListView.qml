import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

ListView {
    id: view
    property int itemHeight: 46
    property int itemRadius: 10
    property bool iconVisible: false
    property bool buttonVisible: false
    property color itemColor: sPalette.base

    SystemPalette {
        id: sPalette
        colorGroup: SystemPalette.Active
    }

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
            color: view.currentIndex === index ? sPalette.highlight :
                                                 (isEnter ? sPalette.button : itemColor)
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
                color: view.currentIndex === index ? sPalette.highlightedText : sPalette.text
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
                icon.source: "qrc:/icon/close.svg"
                buttonRadius: 15
                backgroundDefaultColor: sPalette.base

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

