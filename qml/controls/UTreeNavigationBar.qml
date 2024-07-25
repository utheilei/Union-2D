import QtQuick 2.7
import QtQuick.Controls 2.4 as New
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Old
import QtQuick.Controls.Styles 1.4
import utk.model 1.0
import QtQml.Models 2.15

Old.TreeView {
    id: treeView
    model: treeModel
    height: 600
    selection: selectionModel
    backgroundVisible: false
    alternatingRowColors: false
    sortIndicatorVisible: false
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    headerVisible: false
    frameVisible : false
    property int leftMargin: 20
    property bool iconVisible: true
    property alias treeViewModel: treeModel
    property size iconSize: Qt.size(16, 16)
    signal itemClicked(var index)


    New.ScrollBar {
        id: verticalBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        size: treeView.height / treeView.flickableItem.contentHeight
        width: visible ? 12 : 0
        height: treeView.height
        anchors.top: treeView.top
        anchors.right: treeView.right
        policy: New.ScrollBar.AsNeeded
        onPositionChanged: {
            treeView.flickableItem.contentY = position * (treeView.flickableItem.contentHeight)
        }
    }

    New.ScrollBar {
        id: horizonBar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Horizontal
        size: treeView.width / treeView.flickableItem.contentWidth
        width: treeView.width - verticalBar.width
        height: visible ? 12 : 0
        anchors.bottom: treeView.bottom
        anchors.left: treeView.left
        policy: New.ScrollBar.AsNeeded
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

    TreeModel {
        id: treeModel
        headers: ["title"]
    }

    Connections {
        target: treeModel;
        function onExpandTreeNode(index) {
            treeView.expand(index);
        }
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
        indentation: 0
        branchDelegate: Item {}
        itemDelegate: New.Button {
            id: control
            text: styleData.value
            icon.source: "qrc:/icon/" + UTheme.themeName + "/" + treeModel.itemData(1, styleData.index) + ".svg"
            hoverEnabled: true
            indicator: Canvas {
                id: canvas
                property color penColor: treeModel.childHasSelected(styleData.index, selectionModel.selectedIndexes) ? UTheme.highlight : UTheme.text
                x: control.width - width - control.rightPadding
                y: control.topPadding + (control.availableHeight - height) / 2
                width: styleData.hasChildren ? 12 : 0
                height: styleData.hasChildren ? 7 : 0
                visible: styleData.hasChildren

                Connections {
                    target: control
                    function onPressedChanged() { canvas.requestPaint(); }
                }
                Connections {
                    target: canvas
                    function onPenColorChanged() {canvas.requestPaint(); }
                }

                onPaint: {
                    var context = getContext("2d");
                    context.reset();
                    if (styleData.isExpanded) {
                        context.moveTo(0, 0);
                        context.lineTo(width / 2, height - 1);
                        context.lineTo(width, 0);
                    } else {
                        context.moveTo(0, height - 1);
                        context.lineTo(width / 2, 0);
                        context.lineTo(width, height - 1);
                    }
                    context.lineWidth = 2;
                    context.strokeStyle = penColor;
                    context.stroke();
                }
            }

            contentItem: Item {
                Row {
                    id: rowLayout
                    anchors.fill: parent
                    anchors.leftMargin: leftMargin + styleData.depth * 20
                    anchors.rightMargin: control.indicator.width + control.spacing
                    spacing: 9
                    Image {
                        enabled: control.enabled
                        source: qmlHelper.isImageValid(control.icon.source) ? control.icon.source : ""
                        sourceSize: iconSize
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        id: text
                        text: control.text
                        font: control.font
                        opacity: enabled ? 1.0 : 0.3
                        color: getColor(styleData.hasChildren, styleData.selected, styleData.index, selectionModel.selectedIndexes)
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                }
            }

            background: Rectangle {
                implicitWidth: 160
                implicitHeight: 40
                color: styleData.selected ? UTheme.highlight : (control.hovered ? UTheme.itemBackground : UTheme.base)
                radius : 8
            }
            onClicked: {
                if (styleData.hasChildren) {
                    styleData.isExpanded ? collapse(styleData.index) : expand(styleData.index)
                } else {
                    setCurrentIndex(styleData.index)
                }
                itemClicked(styleData.index)
            }
        }

        rowDelegate: Rectangle {
            height: 40
            color: "transparent"
        }
    }
    function setCurrentIndex(curIndex) {
        selectionModel.setCurrentIndex(curIndex, 19)
    }

    function getColor(hasChildren, selected, index, selectedIndexes) {
        if (hasChildren) {
            return treeModel.childHasSelected(index, selectedIndexes) ?
                        UTheme.highlight : UTheme.text
        } else {
            return selected ? UTheme.highlightedText : UTheme.text
        }
    }
}
