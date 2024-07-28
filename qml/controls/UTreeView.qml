import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import utk.model 1.0
import QtQml.Models 2.15

Old.TreeView {
    id: treeView
    model: treeModel
    selection: selectionModel
    backgroundVisible: false
    alternatingRowColors : false
    sortIndicatorVisible:true
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    headerVisible: false
    frameVisible : false
    property bool dragEnabled: false
    property var dragIndex: null
    property bool iconVisible: true
    property Item currentItem: null
    property alias treeViewModel: treeModel
    signal pressBlankArea()

    MouseArea {
        anchors.fill: treeView
        onPressed: {
            var pressedRow = treeView.indexAt(mouseX, mouseY)
            console.log(pressedRow + " " + treeModel.parent(pressedRow) + mouseX + mouseY)
            if(!pressedRow.valid) {
                treeView.pressBlankArea();
            }
            mouse.accepted = false
        }
    }

    ScrollBar {
        id: verticalBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        size: treeView.height / treeView.flickableItem.contentHeight
        width: visible ? 12 : 0
        height: treeView.height
        anchors.top: treeView.top
        anchors.right: treeView.right
        policy: ScrollBar.AsNeeded
        onPositionChanged: {
            treeView.flickableItem.contentY = position * (treeView.flickableItem.contentHeight)
        }
    }

    ScrollBar {
        id: horizonBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Horizontal
        size: treeView.width / treeView.flickableItem.contentWidth
        width: treeView.width - verticalBar.width
        height: visible ? 12 : 0
        anchors.bottom: treeView.bottom
        anchors.left: treeView.left
        policy: ScrollBar.AsNeeded
        onPositionChanged: {
            treeView.flickableItem.contentX = position * (treeView.flickableItem.contentWidth)
        }
    }

    Connections{
        target: treeView.flickableItem
        function onContentXChanged(x) {
            horizonBar.position = treeView.flickableItem.contentX /
            treeView.flickableItem.contentWidth
        }
    }

    Connections {
        target: treeView.flickableItem
        function onContentYChanged(y) {
            verticalBar.position = treeView.flickableItem.contentY /
                treeView.flickableItem.contentHeight
        }
    }

    UTreeEdit {
        id: edit
        leftPadding: 10
        color: UTheme.text
        editable: false
        text: ""
        onEditFinished: {
            if (null === currentItem)
            {
                return
            }
            treeModel.setData(selectionModel.currentIndex, edit.text)
            currentItem.textVisible = true
            visible = false
        }
        visible: false

        Connections {
            target: treeView
            function onPressBlankArea() {
                if (currentItem != null && edit.visible) {
                    edit.editable = false
                    treeModel.setData(treeView.currentIndex, edit.text)
                    currentItem.textVisible = true
                    edit.visible = false
                    currentItem = null
                }
            }
        }
    }

    onFocusChanged: {
        if (!treeView.focus) {
            edit.editFinished()
        }
    }

    onDoubleClicked: {
        var pos = currentItem.mapToItem(treeView, currentItem.x, currentItem.y)
        edit.x = currentItem.x + 10 + 16
        edit.y = pos.y
        edit.width = currentItem.width
        edit.height = currentItem.height
        edit.text = currentItem.delegateText
        currentItem.textVisible = false
        edit.visible = true
        edit.editable = true
    }

    TreeModel {
        id: treeModel
        headers: ["title"]
    }

    ItemSelectionModel {
        id: selectionModel
        model: treeModel
    }

    Old.TableViewColumn {
        title: "Name"
        role: "edit"
        width: treeView.viewport.width
    }

    style: TreeViewStyle {
        indentation: 20
        branchDelegate : Image {
            sourceSize: Qt.size(15, 15)
            source: styleData.isExpanded ? "qrc:/icon/" + UTheme.themeName + "/utk_expand.svg" : "qrc:/icon/" + UTheme.themeName + "/utk_collapse.svg"
        }
        itemDelegate: Rectangle {
            id: delegateRect
            color: styleData.selected ? UTheme.highlight : (hovered ? UTheme.button : UTheme.itemBackground)
            height: 26
            radius: 10
            property alias delegateText: textItem.text
            property alias textVisible: textItem.visible
            property bool hovered: false

            Image {
                id: icon
                anchors.left: parent.left
                anchors.leftMargin: iconVisible ? 10 : 0
                anchors.verticalCenter: parent.verticalCenter
                sourceSize: Qt.size(16, 16)
                visible: iconVisible
                width: iconVisible ? 16 : 0
                height: iconVisible ? 16 : 0
                source: "qrc:/icon/" + UTheme.themeName + "/" + treeModel.itemData(1, styleData.index) + ".svg"
            }
            Text {
                id: textItem
                anchors.left: icon.right
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 10
                color: styleData.selected ? UTheme.highlightedText : UTheme.text
                text: styleData.value
                elide: Text.ElideRight
                width: parent.width - 26
            }
            MouseArea {
                id: rowMouseArea
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                propagateComposedEvents: true
                hoverEnabled: true
                drag.target: dragEnabled ? delegateRect : null
                drag.onActiveChanged: {
                    if (rowMouseArea.drag.active) {
                        dragIndex = styleData.index
                    }
                    delegateRect.Drag.drop()
                }
                onPressed: {
                    if (currentItem != null && edit.visible) {
                        console.log(delegateRect.x + " " + delegateRect.y)
                        edit.editable = false
                        edit.editFinished()
                    }
                    currentItem = delegateRect
                    setCurIndex(styleData.index)
                }
                onEntered: {
                    delegateRect.hovered = true
                }
                onExited: {
                    delegateRect.hovered = false
                }
            }
            states: [
                State {
                    when: delegateRect.Drag.active
                    ParentChange {
                        target: delegateRect
                        parent: treeView; width: delegateRect.width; height: delegateRect.height
                    }

                    AnchorChanges {
                        target: delegateRect
                        anchors.horizontalCenter: undefined
                        anchors.verticalCenter: undefined
                    }
                }
            ]
            Drag.keys: ["treeItem"]
            Drag.active: rowMouseArea.drag.active
            Drag.supportedActions: Qt.CopyAction;
            Drag.hotSpot.x: delegateRect.width / 2
            Drag.hotSpot.y: delegateRect.height / 2
        }

        rowDelegate: Rectangle {
            height: 26
            color: "transparent"
            property bool dropHoverd: false
            border.width: 1
            border.color: dropHoverd ? UTheme.errorBackground : "transparent"
            DropArea {
                id: dropArea
                enabled: dragEnabled
                anchors.fill: parent
                keys: ["treeItem"]
                onDropped: {
                    var pos = dropArea.mapToItem(treeView, drop.x, drop.y)
                    treeModel.moveItem(dragIndex, 0, treeView.indexAt(pos.x, pos.y), styleData.row)
                    dropHoverd = false
                }
                onEntered: {
                    dropHoverd = true
                }
                onExited: {
                    dropHoverd = false
                }
            }
        }
    }

    function setCurIndex(curIndex) {
        selectionModel.setCurrentIndex(curIndex, 19)
    }
}
