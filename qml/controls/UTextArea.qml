import QtQuick 2.11
import QtQuick.Controls 2.4
import utk.window 1.0

TextArea {
    id: myTextArea

    property int maximumWidth: -1
    selectByKeyboard: true
    selectByMouse: true
    wrapMode: TextEdit.WordWrap
    antialiasing: true
    textFormat: Text.RichText
    color: UTheme.text

    QuickTextDocument {
        id: mydocument
        quickTextDocument: myTextArea.textDocument
        cursorPosition: myTextArea.cursorPosition

        onImageUpdate: {
            let alpha = myTextArea.color.a;
            myTextArea.color.a = alpha - 0.01;
            myTextArea.color.a = alpha;
        }
    }

    Component.onCompleted: {
        if (myTextArea.length === 0)
            return
        if (maximumWidth < 0)
            return

        if (myTextArea.width > maximumWidth)
            myTextArea.width = maximumWidth
        mydocument.processQuickImage(myTextArea.text);
    }

    function insertQuickImage(source) {
        mydocument.insertQuickImage(source)
    }

    function clearText() {
        myTextArea.clear();
        mydocument.clear();
    }

    function toPlainText() {
        return mydocument.toPlainText()
    }

    Keys.onPressed: {
        if ((event.key === Qt.Key_V) && (event.modifiers & Qt.ControlModifier)) {
            if (myTextArea.readOnly === true)
                return
            event.accepted = true;
            mydocument.processPasteText();
        }
    }
}
