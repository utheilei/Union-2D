import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import "../"
import utk.window 1.0

ListView {
    id: view
    property int itemHeight: 46
    property int itemRadius: 10
    property int fontSize: 14
    property bool iconVisible: false
    property bool buttonVisible: false
    property color itemColor: UTheme.itemBackground
    signal hoverChanged(var isHovered)
    signal itemDataChanged(var itemData)
    enum ItemRoles {
        Group,
        Member
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
            color: view.currentIndex === index ? UTheme.highlight :
                                                 (isEnter ? UTheme.button : itemColor)
            Image {
                id: iconItem
                anchors.left: parent.left
                anchors.leftMargin: iconVisible ? 10 : 0
                anchors.verticalCenter: parent.verticalCenter
                source: sourceUrl
                sourceSize: Qt.size(35, 35)
                visible: (UListView.ItemRoles.Group === itemRole) ? false : iconVisible
                width: visible ? sourceSize.width : 0
                height: visible ? sourceSize.height : 0
            }

            Text {
                id: itemText
                anchors.left: iconItem.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: (parent.width - iconItem.width - closeButton.width - 20 -
                        (iconItem.visible ? 10 : 0) - (closeButton.visible ? 10 : 0))
                text: itemName
                color: (UListView.ItemRoles.Group === itemRole) ? qmlHelper.colorAlpha(UTheme.text, 0.3*255)
                                                                : (view.currentIndex === index ? UTheme.highlightedText : UTheme.text)
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                font.family: "Microsoft YaHei"
                font.pixelSize: fontSize
            }

            URoundedButton {
                id: closeButton
                width: visible ? 30 : 0
                height: visible ? 30 : 0
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                visible: false
                icon.source: "qrc:/icon/" + UTheme.themeName + "/close.svg"
                buttonRadius: 15
                backgroundDefaultColor: UTheme.base

                onClicked: {
                    console.info(index)
                    listModel.remove(index)
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: UTheme.frameBorder
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                visible: UListView.ItemRoles.Group === itemRole
            }

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: {
                    view.focus = true
                    if (UListView.ItemRoles.Member === itemRole) {
                        view.currentIndex = index
                        itemDataChanged(itemData)
                    }
                    mouse.accepted = false
                }
                onEntered: {
                    if (UListView.ItemRoles.Group === itemRole)
                        return
                    isEnter = true
                    if (buttonVisible)
                        closeButton.visible = true
                    hoverChanged(true)
                }
                onExited: {
                    if (UListView.ItemRoles.Group === itemRole)
                        return
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

