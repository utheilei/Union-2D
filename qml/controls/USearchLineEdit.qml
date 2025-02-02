import QtQuick 2.7
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import "../"

Rectangle {
    id: searchEdit
    radius: 8
    color: edit.alertControl.visible ? UTheme.errorBackground : UTheme.button
    implicitWidth: 260
    implicitHeight: 36
    border.color: edit.activeFocus ? UTheme.highlight : UTheme.button
    border.width: edit.activeFocus? 1 : 0
    signal returnPressed
    signal editTextChanged
    property alias placeholderText: edit.placeholderText
    property alias text: edit.text

    RowLayout {
        anchors.fill: parent
        spacing: 6
        ULineEdit {
            id: edit
            placeholderText: qsTr("搜索")
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle {
                color: "transparent"
                radius: 10
                border.width: 0
            }
            Component.onCompleted: {
                setCloseButtonVisible(false)
                edit.returnPressed.connect(searchEdit.returnPressed)
            }
            onTextChanged: searchEdit.editTextChanged()
        }
        Image {
            id: search
            Layout.rightMargin: 8
            Layout.alignment: Qt.AlignVCenter
            width: 30
            height: 30
            source: "qrc:/icon/" + UTheme.themeName + "/search.svg"
            sourceSize: Qt.size(24, 24)
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: searchEdit.returnPressed()
            }
        }
    }

    function showAlertMessage(text, duration) {
        edit.showAlertMessage(text, duration)
    }
}
