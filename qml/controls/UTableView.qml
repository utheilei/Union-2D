import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4

TableView {
    id: view
    //列宽
    property variant columnWidthArr: [100,100,100,200]
    property int columnMiniwidth: 80
    frameVisible: false
    backgroundVisible: false

    function resizeColumn() {
        var width = 0;
        for(var i = 0; i< (view.columnCount - 1); i++)
            width = width + view.getColumn(i).width
        return view.width - width
    }

    selectionMode: SelectionMode.SingleSelection
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    sortIndicatorVisible: true
    sortIndicatorOrder : Qt.AscendingOrder  /*Qt.DescendingOrder*/
    sortIndicatorColumn : 0

    ScrollBar {
        id: verticalBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        size: view.height / view.flickableItem.contentHeight
        width: visible ? 12 : 0
        height: view.height
        anchors.top: view.top
        anchors.topMargin: 36
        anchors.right: view.right
        policy: ScrollBar.AsNeeded
        onPositionChanged: {
            view.flickableItem.contentY = position * (view.flickableItem.contentHeight)
        }
    }

    ScrollBar {
        id: horizonBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Horizontal
        size: view.width / view.flickableItem.contentWidth
        width: view.width - verticalBar.width
        height: visible ? 12 : 0
        anchors.bottom: view.bottom
        anchors.left: view.left
        policy: ScrollBar.AsNeeded
        onPositionChanged: {
            view.flickableItem.contentX = position * (view.flickableItem.contentWidth)
        }
    }

    Connections{
        target: view.flickableItem
        function onContentXChanged(x) {
            horizonBar.position = view.flickableItem.contentX /
            view.flickableItem.contentWidth
        }
    }

    Connections {
        target: view.flickableItem
        function onContentYChanged(y) {
            verticalBar.position = view.flickableItem.contentY /
                view.flickableItem.contentHeight
        }
    }

    headerDelegate: Rectangle {
        id: hearRectangle
        width: columnWidthArr[styleData.column]
        height: 36
        color: UTheme.base

        Text {
            anchors.fill: parent
            text: view.model.headerData(styleData.column, Qt.Horizontal)
            color: UTheme.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.top: hearRectangle.top
            height: parent.height
            width: 1
            color: UTheme.frameBorder
            visible: styleData.column !== 0
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.bottom: hearRectangle.bottom
            height: 1
            width: parent.width
            color: UTheme.frameBorder
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.top: hearRectangle.top
            height: 1
            width: parent.width
            color: UTheme.frameBorder
        }
    }

    itemDelegate: Item {
        width: view.getColumn(styleData.column).width
        height: 36
        Text {
            anchors.fill: parent
            text: styleData.value
            elide: Text.ElideMiddle
            color: styleData.selected ? UTheme.highlightedText : UTheme.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    rowDelegate: Rectangle {
        id: rowRectangle
        property bool hovered: false
        width: view.viewport.width - 10
        height: 36
        radius: 8
        color: styleData.selected ? UTheme.highlight : (rowRectangle.hovered ? UTheme.button : UTheme.itemBackground)
        MouseArea {
            id: rowMouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            propagateComposedEvents: true
            hoverEnabled: true
            onEntered: rowRectangle.hovered = true
            onExited: rowRectangle.hovered = false
            onPressed: mouse.accepted = false
            onReleased: mouse.accepted = false
            onClicked: mouse.accepted = false
        }
    }

    function getItemPosition(column) {
        switch(column) {
        case 0:
            return URadiusRectangle.ItemPosition.TopRight | URadiusRectangle.ItemPosition.BottomRight
        case view.columnCount - 1:
            return URadiusRectangle.ItemPosition.TopLeft | URadiusRectangle.ItemPosition.BottomLeft
        default:
            return URadiusRectangle.ItemPosition.All
        }
    }
}
