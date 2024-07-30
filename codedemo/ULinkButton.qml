import QtQuick 2.7
import QtQuick.Controls 2.4

Button {
    id: closeButton
    property color textColor: "#0082FA"
    hoverEnabled: true

    contentItem: Text {
        text: "ULinkButton"
        font: closeButton.font
        opacity: closeButton.enabled ? 1.0 : 0.3
        color: closeButton.down ? Qt.darker(textColor, 1.2) :
                                  (closeButton.hovered ? Qt.lighter(textColor, 1.2) : textColor)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Item {}
}
