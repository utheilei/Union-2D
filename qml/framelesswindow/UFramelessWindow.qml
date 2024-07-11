import QtQuick 2.12
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.12

Page {
    property QtObject parentObj
    property QtObject titleBar: hlTitleBar
    id: root
    anchors.fill: parent;
    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    //标题栏
    UTitleBar {
        id: hlTitleBar
        x: parent.x
        y: parent.y
        width: parent.width
        height: 50
        parentObj: root.parentObj
        source: appIcon
    }

    //窗口拉伸
    UCustomMouseArea{
        id:left;
        type: 3;
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id:right;
        type: 4;
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id:top;
        type: 1;
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id:bottom;
        type: 2;
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id:topLeft;
        type: 5;
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id:topRight;
        type: 6;
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        parentObj: root.parentObj
    }
    UCustomMouseArea{
        id: bottomLeft
        anchors.left:parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        parentObj: root.parentObj
        type: 7
    }
    UCustomMouseArea{
        id:bottomRight;
        type: 8;
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        parentObj: root.parentObj
    }
}
