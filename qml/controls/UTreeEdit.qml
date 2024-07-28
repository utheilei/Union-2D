import QtQuick 2.12
import QtQuick.Controls 2.12

TextInput {
    signal editFinished()
    property bool editable: true
    onEditableChanged: {
        if (editable) {
            forceActiveFocus()
            ensureVisible(0)
        } else {
            deselect()
        }
    }
    readOnly: !editable
    selectByMouse: editable
    verticalAlignment: Text.AlignVCenter

    onFocusChanged: {
        if (!focus && editable) {
            editFinished()
            editable = false
            deselect()
        }
    }
    Keys.enabled: editable
    Keys.onReturnPressed: {
        editFinished()
        editable = false
        deselect()
    }
    Keys.onEnterPressed: {
        editFinished()
        editable = false
        deselect()
    }
}
