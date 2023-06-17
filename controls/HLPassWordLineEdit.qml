import QtQuick 2.7
import QtQuick.Controls 2.4
import "../"

Item {
    id: name
    signal returnPressed
    property alias text: qmlLineEdit.text
    width: 200
    height:  38

    HLLineEdit {
        id: qmlLineEdit
        width: parent.width - qmlButton.width - 10
        height: parent.height
        isPassword: true
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        onReturnPressed: {name.returnPressed()}
    }

    HLRoundedButton {
        id: qmlButton
        width: qmlLineEdit.height + 2
        height: qmlLineEdit.height
        anchors.left: qmlLineEdit.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        backgroundDefaultColor: windowTheme.highlight
        icon.source: (windowTheme.theme === 0) ? "qrc:/icon/light/passwordshow.svg" : "qrc:/icon/dark/passwordshow.svg"

        onClicked: {
            qmlLineEdit.isPassword = !qmlLineEdit.isPassword
            icon.source = qmlLineEdit.isPassword ?
                        ((windowTheme.theme === 0) ? "qrc:/icon/light/passwordshow.svg" : "qrc:/icon/dark/passwordshow.svg")
                      : ((windowTheme.theme === 0) ? "qrc:/icon/light/passwordhide.svg" : "qrc:/icon/dark/passwordhide.svg")
        }
    }

    function lineEdit() {
        return qmlLineEdit
    }

    function showAlertMessage(text, duration) {
        qmlLineEdit.showAlertMessage(text, duration)
    }
}


