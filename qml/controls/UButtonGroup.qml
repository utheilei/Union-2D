import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15

Rectangle {
    signal buttonClicked(var index)
    property int checkedIndex: 0
    property alias model: repeater.model
    color: UTheme.button
    radius: 6
    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.margins: 4
        spacing: 0
        Repeater {
            id: repeater
            URoundedButton {
                buttonRadius: 6
                Layout.fillHeight: true
                Layout.fillWidth: true
                checkable: true
                checked: (checkedIndex === index) ? true : false
                autoExclusive: true
                text: modelData[0]
                icon.source: modelData[1]
                onClicked: {
                    buttonClicked(index)
                }
            }
        }
    }
}
