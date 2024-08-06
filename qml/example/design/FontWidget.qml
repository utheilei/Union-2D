import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import QtQuick.Controls 1.4 as Old
import utk.model 1.0
import "../../controls"

ScrollView {
    id: scrollView
    clip: true

    ListModel {
        id: fontModel
        ListElement {
            fontSystem: "Windows"
            fontName: "镭"
            fontFamily: "Microsoft Yahei"
        }
        ListElement {
            fontSystem: "macOS"
            fontName: "镭"
            fontFamily: "PingFang"
        }
    }

    ListModel {
        id: fontPxModel
        ListElement {
            fontPx: 64
            fontHeight: 72
        }
        ListElement {
            fontPx: 48
            fontHeight: 56
        }
        ListElement {
            fontPx: 36
            fontHeight: 44
        }
        ListElement {
            fontPx: 28
            fontHeight: 36
        }
        ListElement {
            fontPx: 24
            fontHeight: 32
        }
        ListElement {
            fontPx: 20
            fontHeight: 28
        }
        ListElement {
            fontPx: 16
            fontHeight: 24
        }
        ListElement {
            fontPx: 14
            fontHeight: 22
        }
        ListElement {
            fontPx: 12
            fontHeight: 20
        }
    }

    ListModel {
        id: fontWeightModel
        ListElement {
            fontWeight: Font.Bold
            weightEnum: "Font.Bold"
            weightNum: 700
        }
        ListElement {
            fontWeight: Font.Normal
            weightEnum: "Font.Normal"
            weightNum: 400
        }
    }

    Component {
        id: fontCard
        Rectangle {
            id: rect
            color: "transparent"
            border.width: 2
            border.color: UTheme.frameBorder
            radius: 8
            width: 280
            height: 140
            Column {
                anchors.fill: parent
                anchors.margins: 16
                Label {
                    color: UTheme.text
                    font.pixelSize: 16
                    font.bold: true
                    text: fontSystem
                }
                Rectangle {
                    width: parent.width
                    height: 1
                    color: UTheme.frameBorder
                }
                Row {
                    id: centerItem
                    width: parent.width
                    height: 96
                    spacing: 20
                    leftPadding: 10
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                        font.pixelSize: 48
                        font.family: fontFamily
                        font.bold: true
                        text: fontName
                    }
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                        font.pixelSize: 20
                        text: fontFamily
                    }
                }
            }
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 30
        Label {
            font.pixelSize: 30
            font.bold: true
            color: UTheme.text
            text: qsTr("Font字体")
        }
        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       字体是界面设计中最基本的构成之一。Union-2D中定义了字体使用规范，包含字体、字阶、行高、字重，字色参考颜色章节")
            wrapMode: Text.WordWrap
        }
        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("字体")
        }

        Flow {
            width: scrollView.width - 40
            height: 140
            spacing: 20
            Repeater {
                model: fontModel
                delegate: fontCard
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("字阶/行高")
        }

        Column {
            width: scrollView.width - 40
            leftPadding: 20
            spacing: 20
            Repeater {
                model: fontPxModel
                Label {
                    font.pixelSize: fontPx
                    color: UTheme.text
                    text: fontPx + "px Union-2D " + fontHeight + "px"
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("字重")
        }

        Column {
            width: scrollView.width - 40
            spacing: 20
            leftPadding: 20
            Repeater {
                model: fontWeightModel
                Text {
                    font.pixelSize: 20
                    font.weight: fontWeight
                    font.family: "Microsoft Yahei"
                    color: UTheme.text
                    text: "Union-2D (" + weightNum + ")" + " enum " + weightEnum
                }
            }
        }

        Item {
            id: name
            width: 100
            height: 20
        }
    }
}
