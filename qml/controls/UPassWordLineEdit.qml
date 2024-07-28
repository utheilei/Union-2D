import QtQuick 2.7
import QtQuick.Controls 2.4
import "../"

Item {
    id: name
    signal returnPressed
    signal editTextChanged
    property alias text: qmlLineEdit.text
    width: 200
    height:  38

    ULineEdit {
        id: qmlLineEdit
        width: parent.width - qmlButton.width - 10
        height: parent.height
        isPassword: true
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        onTextChanged: name.editTextChanged()
        onReturnPressed: {name.returnPressed()}
    }

    URoundedButton {
        id: qmlButton
        width: qmlLineEdit.height + 2
        height: qmlLineEdit.height
        anchors.left: qmlLineEdit.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        backgroundDefaultColor: UTheme.highlight
        icon.source: "qrc:/icon/" + UTheme.themeName + "/passwordshow.svg"

        onClicked: {
            qmlLineEdit.isPassword = !qmlLineEdit.isPassword
            icon.source = qmlLineEdit.isPassword ?
                        ("qrc:/icon/" + UTheme.themeName + "/passwordshow.svg")
                      : ("qrc:/icon/" + UTheme.themeName + "/passwordhide.svg")
        }
    }

    function lineEdit() {
        return qmlLineEdit
    }

    function showAlertMessage(text, duration) {
        qmlLineEdit.showAlertMessage(text, duration)
    }
}


