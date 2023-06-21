import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import "../"

Rectangle {
    id: searchEdit
    radius: 8
    color: edit.alertControl.visible ? windowTheme.warningColor : windowTheme.button
    implicitWidth: 260
    implicitHeight: 36
    border.color: edit.activeFocus ? windowTheme.highlight : windowTheme.button
    border.width: edit.activeFocus? 1.5 : 0
    signal returnPressed

    RowLayout {
        anchors.fill: parent
        spacing: 6
        HLLineEdit {
            id: edit
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle {
                color: "transparent"
                radius: 10
                border.width: 0
            }
            Component.onCompleted: {
                setCloseButtonVisible(false)
                edit.returnPressed.connect(returnPressed)
            }
        }
        Image {
            id: search
            Layout.rightMargin: 8
            width: Math.min(searchEdit.width, searchEdit.height)
            source: (windowTheme.theme === 0) ? "qrc:/icon/light/search.svg" : "qrc:/icon/dark/search.svg"
            sourceSize: Qt.size(searchEdit.height/3*2, searchEdit.height/3*2)
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: returnPressed()
            }
        }
    }

    function showAlertMessage(text, duration) {
        edit.showAlertMessage(text, duration)
    }
}
