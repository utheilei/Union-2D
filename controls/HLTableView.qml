import QtQuick 2.11
import QtQuick.Controls 2.4
import TableModel 1.0
import QtQuick.Controls 1.4

TableView {
    id: view
    //列宽
    property variant columnWidthArr: [100,100,100,200]
    property int columnMiniwidth: 80
    frameVisible: false

    TableModel {
        id: tableModel
        horHeader: ["Id","Name","Age","Note"]
    }

    model: tableModel

    TableViewColumn {
        title: "Id"
        width: 100
        movable: false
    }
    TableViewColumn {
        title: "Name"
        width: 100
        movable: false
    }

    TableViewColumn {
        title: "Age"
        width: 100
        movable: false
    }

    TableViewColumn {
        title: "Note"
        width: resizeColumn()
        movable: false
        resizable: false
    }

    function resizeColumn() {
        var width = 0;
        for(var i = 0; i< (view.columnCount - 1); i++)
            width = width + view.getColumn(i).width
        return view.width - width
    }

    selectionMode: SelectionMode.SingleSelection
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    sortIndicatorVisible: true
    sortIndicatorOrder : Qt.AscendingOrder  /*Qt.DescendingOrder*/
    sortIndicatorColumn : 0

    headerDelegate: Rectangle {
        id: hearRectangle
        width: columnWidthArr[styleData.column]
        height: 36

        Text {
            anchors.fill: parent
            text: tableModel.headerData(styleData.column, Qt.Horizontal)
            color: windowTheme.windowText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.top: hearRectangle.top
            height: parent.height
            width: 1
            color: windowTheme.dark
            visible: styleData.column !== 0
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.bottom: hearRectangle.bottom
            height: 1
            width: parent.width
            color: windowTheme.dark
        }

        Rectangle{
            anchors.left: hearRectangle.left
            anchors.top: hearRectangle.top
            height: 1
            width: parent.width
            color: windowTheme.dark
        }
    }

    itemDelegate: Rectangle {
        width: view.getColumn(styleData.column).width
        height: 36
        radius: 10
        color: styleData.selected ? windowTheme.highlight : windowTheme.button

        Rectangle {
            anchors.fill: parent
            color: styleData.selected ? windowTheme.highlight : windowTheme.button
            visible: styleData.column !== 0 && styleData.column !== view.columnCount - 1
        }

        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width/2
            height: parent.height
            color: styleData.selected ? windowTheme.highlight : windowTheme.button
            visible: styleData.column === view.columnCount - 1
        }

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            width: parent.width/2
            height: parent.height
            color: styleData.selected ? windowTheme.highlight : windowTheme.button
            visible: styleData.column === 0
        }

        Text {
            anchors.fill: parent
            text: tableModel.item(styleData.row, styleData.column)
            elide: Text.ElideMiddle
            color: styleData.selected ? windowTheme.highlightedText : windowTheme.windowText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    rowDelegate: Rectangle {
        width: view.viewport.width
        height: 36
        radius: 10
        color: "transparent"
    }

    Component.onCompleted: {
        tableModel.insertItem(tableModel.rowCount(), [3, "Name", 32, "Note"])
//        tableModel.removeItem(1)
    }
}
