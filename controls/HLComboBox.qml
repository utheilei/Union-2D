import QtQuick 2.7
import QtQuick.Controls 2.4

ComboBox {
    id: control
    x: 300
    y: 60
    model: ["First", "Second", "Third"]

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: modelData
            color: "#21be2b"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: control.pressed ? "#17a81a" : "#21be2b"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        border.color: control.pressed ? "#17a81a" : "#21be2b"
        border.width: control.activeFocus ? 2 : 1
        radius: 2
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#21be2b"
            radius: 2
        }
    }
}

//Rectangle {
//    id: myComboBox
//    x: 10
//    y: 60
//    width: 150
//    height: 40
//    border.color: control.pressed ? "#17a81a" : "#21be2b"
//    border.width: control.contentItem.activeFocus ? 2 : 1
//    radius: 10

//    ComboBox {
//        id: control
//        editable: true
//        width: myComboBox.width - 4
//        height: myComboBox.height - 4
//        anchors.centerIn: parent
//        indicator: Rectangle {
//            id: indicatorRectangle
//            anchors.right: control.right
//            anchors.verticalCenter: control.verticalCenter
//            width: control.height
//            height: control.height
//            radius: 10
//            Image {
//                anchors.centerIn: parent
//                source: "qrc:/close.svg"
//                sourceSize: Qt.size(10, 10)
//            }
//        }

//        delegate: ItemDelegate {
//            width: control.width
//            contentItem: Item {
//                Image {
//                    id: name
//                    anchors.left: parent.left
//                    anchors.verticalCenter: parent.verticalCenter
//                    source: "qrc:/dialog.svg"
//                    sourceSize: Qt.size(40, 40)
//                }
//                Text {
//                    anchors.left: name.right
//                    anchors.leftMargin: 5
//                    anchors.verticalCenter: parent.verticalCenter
//                    text: modelData
//                    color: "#21be2b"
//                    font: control.font
//                    elide: Text.ElideRight
//                    verticalAlignment: Text.AlignVCenter
//                }
//            }
//            highlighted: control.highlightedIndex === index
//        }

//        model: ListModel {
//            id: model
//            ListElement { text: "Banana" }
//            ListElement { text: "Apple" }
//            ListElement { text: "Coconut" }
//        }

//        Component.onCompleted: {
//            background.color = "transparent"
//            background.radius = 10
//            contentItem.background.radius = 10
//            contentItem.background.border.width = 0
//        }
//    }
//}
