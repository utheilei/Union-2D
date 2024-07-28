import QtQuick 2.12
import QtQuick.Controls 2.3

ScrollView {
    signal iconItemClicked(var index)
    property alias model: repeater.model
    property QtObject parentObj;
    property int count
    property int itemWidth: 170
    property int paddings
    id: scrollView
    topPadding: 20
    clip: true
    Grid {
        anchors.centerIn: parent
        leftPadding: paddings
        rightPadding: paddings
        rowSpacing: 20
        columnSpacing: 20
        columns: count

        Repeater {
            id: repeater
            UIconItem {
                width: itemWidth
                height: itemWidth
                icon: modelData[1]
                label: modelData[0]

                onItemClicked: {
                    iconItemClicked(index)
                }
            }
        }
    }
    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    function updateItem() {
        for(var i = 0; i< repeater.count; i++) {
            repeater.itemAt(i).color = UTheme.button
        }
    }

    Component.onCompleted: {
        UTheme.applicationThemeChanged.connect(scrollView.updateItem)
    }

    Component.onDestruction: {
        UTheme.applicationThemeChanged.disconnect(scrollView.updateItem)
    }
}
