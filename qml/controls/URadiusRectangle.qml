import QtQuick 2.12
import QtQuick.Controls 2.15

Rectangle {
    enum ItemPosition {
        TopLeft = 0x0001,
        TopRight = 0x0010,
        BottomLeft = 0x0100,
        BottomRight = 0x1000,
        All = 0x1111
    }

    property color itemColor: UTheme.itemBackground
    property var itemPosition: URadiusRectangle.ItemPosition.All

    radius: 8
    color: itemColor

    Rectangle {
        implicitWidth: parent.width/2
        implicitHeight: parent.height/2
        anchors.left: parent.left
        anchors.top: parent.top
        color: itemColor
        border.width: 0
        visible: itemPosition & URadiusRectangle.ItemPosition.TopLeft
    }

    Rectangle {
        implicitWidth: parent.width/2
        implicitHeight: parent.height/2
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: itemColor
        border.width: 0
        visible: itemPosition & URadiusRectangle.ItemPosition.BottomLeft
    }

    Rectangle {
        implicitWidth: parent.width/2
        implicitHeight: parent.height/2
        anchors.right: parent.right
        anchors.top: parent.top
        color: itemColor
        border.width: 0
        visible: itemPosition & URadiusRectangle.ItemPosition.TopRight
    }

    Rectangle {
        implicitWidth: parent.width/2
        implicitHeight: parent.height/2
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: itemColor
        border.width: 0
        visible: itemPosition & URadiusRectangle.ItemPosition.BottomRight
    }
}
