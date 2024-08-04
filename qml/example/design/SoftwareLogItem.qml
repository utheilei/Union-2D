import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../../controls"

Item {
    property alias titleIcon: titleImage.source
    property alias featureIcon: featureImage.source
    property alias fixBugIcon: fixBugImage.source
    property alias itemVersion: versionText.text
    property alias itemTime: timeText.text
    property alias featureModel: featureRepeater.model
    property alias fixBugModel: fixBugRepeater.model
    property bool lineVisible: true
    height: (featureRepeater.count + fixBugRepeater.count) * 30 + 120
            + (featureList.visible ? 30 : 0) + (fixBugList.visible ? 30 : 0)

    RowLayout {
        anchors.fill: parent
        Column {
            Layout.preferredWidth: 40
            Layout.fillHeight: true
            spacing: 6
            Item {
                height: 8
                width: 10
            }
            Rectangle {
                color: UTheme.highlight
                height: 10
                width: 10
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle {
                visible: lineVisible
                color: UTheme.highlight
                height: parent.height - 24
                width: 2
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Column {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0
            Row {
                height: 40
                spacing: 10
                Image {
                    id: titleImage
                    sourceSize: Qt.size(36, 36)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    id: versionText
                    color: UTheme.text
                    font.pixelSize: 20
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle {
                    color: UTheme.button
                    height: 36
                    width: 120
                    radius: 8
                    anchors.verticalCenter: parent.verticalCenter
                    Label {
                        id: timeText
                        color: UTheme.text
                        font.pixelSize: 20
                        font.bold: true
                        anchors.centerIn: parent
                    }
                }
            }
            Item {
                width: 100
                height: 30
            }
            Row {
                height: 30
                spacing: 10
                visible: featureList.visible
                Image {
                    id: featureImage
                    sourceSize: Qt.size(26, 26)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    color: UTheme.text
                    text: "Features"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Column {
                id: featureList
                visible: featureRepeater.count > 0
                Repeater {
                    id: featureRepeater
                    Row {
                        height: 30
                        spacing: 10
                        Rectangle {
                            width: 10
                            height: 10
                            color: UTheme.splitLineBackground
                            radius: height/2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Label {
                            color: UTheme.text
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
            Item {
                width: 100
                visible: fixBugList.visible
                height: 30
            }
            Row {
                height: 30
                spacing: 10
                visible: fixBugList.visible
                Image {
                    id: fixBugImage
                    sourceSize: Qt.size(26, 26)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    color: UTheme.text
                    text: "Bug Fixes"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Column {
                id: fixBugList
                visible: fixBugRepeater.count > 0
                Repeater {
                    id: fixBugRepeater
                    Row {
                        height: 30
                        spacing: 10
                        Rectangle {
                            width: 10
                            height: 10
                            color: UTheme.splitLineBackground
                            radius: height / 2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Label {
                            color: UTheme.text
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
