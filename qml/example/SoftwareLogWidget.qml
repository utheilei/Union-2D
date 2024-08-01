import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../controls"

ScrollView {
    id: scrollView
    clip: true
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30
        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("更新日志")
        }

        Column {
            width: scrollView.width - 20
            Repeater {
                id: listRepeater
                model: qmlHelper.softwareLogs()
                SoftwareLogItem {
                    lineVisible: index < (listRepeater.count - 1)
                    width: parent.width
                    titleIcon: "qrc:/icon/" + UTheme.themeName + "/softwarelog.svg"
                    featureIcon: "qrc:/icon/" + UTheme.themeName + "/features.svg"
                    fixBugIcon: "qrc:/icon/" + UTheme.themeName + "/fixbug.svg"
                    itemVersion: modelData.version
                    itemTime: modelData.time
                    featureModel: modelData.Features
                    fixBugModel: modelData.Fixes
                }
            }
        }
    }
}
