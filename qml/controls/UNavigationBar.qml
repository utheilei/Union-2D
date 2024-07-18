import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

Item {
    signal buttonClicked(var index)
    property int checkedIndex: 0
    property size iconSize: Qt.size(16, 16)
    property size buttonSize: Qt.size(80, 40)
    property alias model: repeater.model
    property bool iconVisible: true

    Row {
        id: rowLayout
        anchors.fill: parent
        spacing: 0
        Repeater {
            id: repeater
            Button {
                id: control
                checkable: true
                checked: (checkedIndex === index) ? true : false
                autoExclusive: true
                text: modelData[0]
                icon.source: modelData[1]
                contentItem: Item {
                    Row {
                        anchors.centerIn: parent
                        spacing: 5
                        USVGIcon {
                            enabled: iconVisible ? control.enabled : false
                            source: control.icon.source
                            anchors.verticalCenter: parent.verticalCenter
                            visible: iconVisible
                            color: control.checked ? UTheme.highlight : UTheme.text
                            width: iconVisible ? iconSize.width : 0
                            height: iconVisible ? iconSize.height : 0
                        }
                        Text {
                            id: text
                            enabled: control.enabled
                            text: control.text
                            font: control.font
                            opacity: enabled ? 1.0 : 0.3
                            color: control.checked ? UTheme.highlight : UTheme.text
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                    }
                    NumberAnimation on scale {
                        to: 1.2
                        running: control.checked ? true : false
                        duration: 200
                    }
                    NumberAnimation on scale {
                        to: 1.0
                        running: control.checked ? false : true
                        duration: 200
                    }
                }

                background: Item {
                    clip: true
                    implicitWidth: buttonSize.width
                    implicitHeight: buttonSize.height
                    Rectangle {
                        color: control.checked ? UTheme.highlight : "transparent"
                        height: 2
                        width: parent.width
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                    }
                }
                onClicked: {
                    buttonClicked(index)
                }
            }
        }
    }
    function itemAt(index) {
        return repeater.itemAt(index)
    }
}
