import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

Rectangle {
    id: rect
    property alias component: myLoader.sourceComponent
    property alias item: myLoader.item
    property alias switchText: itemText.text
    property alias titleText: titleLabel.text
    property alias itemText: bottomLabel.text
    property alias itemFont: titleLabel.font
    signal switchClicked(var checked)
    signal rightButtonClicked()
    color: "transparent"
    border.width: 2
    border.color: UTheme.frameBorder
    radius: 8

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        Item {
            id: titleItem
            Layout.fillWidth: true
            height: 36
            Label {
                id: titleLabel
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: UTheme.text
            }
            USwitch {
                id: switchCard
                anchors.leftMargin: 10
                anchors.left: titleLabel.right
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged: switchClicked(switchCard.checked)
            }
            Text {
                id: itemText
                anchors.leftMargin: 2
                anchors.left: switchCard.right
                anchors.verticalCenter: parent.verticalCenter
                font: titleLabel.font
                opacity: rect.enabled ? 1.0 : 0.3
                color: UTheme.text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            UButton {
                id: giteeButton
                anchors.rightMargin: 10
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: 30
                implicitHeight: 30
                icon.source: "qrc:/icon/" + UTheme.themeName + "/codedome.svg"
                onClicked: rightButtonClicked()
            }
        }
        Rectangle{
            Layout.fillWidth: true
            height: 1
            color: UTheme.frameBorder
        }
        Item {
            id: centerItem
            Layout.fillWidth: true
            Layout.fillHeight: true
            Loader {
                id: myLoader
                anchors.fill: parent
            }
        }
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: UTheme.frameBorder
        }
        Label {
            id: bottomLabel
            Layout.fillWidth: true
            color: UTheme.text
            wrapMode: Text.WordWrap
        }
    }
}
