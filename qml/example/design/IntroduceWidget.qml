import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import "../../controls"

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
            text: qsTr("Union-2D")
        }
        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       Union-2D遵循美观性，完整性，风格统一性，易用性等设计理念，打造一款通用开发框架平台。在此基础上，Union-2D提供了开箱即用的UI组件库、设计指南和研发指南，Demo案例，将设计和研发从重复劳动中解放出来，同时也支持在Union-2D的基础上进行扩展，便于UX设计和开发人员协同开发。")
            wrapMode: Text.WordWrap
        }
        Item {
            id: item
            height: 660
            width: scrollView.width
            CricleComponent {
                width: 140
                x: 170
                y: 0
                Row {
                    spacing: 6
                    width: fname.width + ftitle.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: fname
                        text: "F"
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: fname
                            start: Qt.point(0, 0)
                            end: Qt.point(fname.width, 0)
                            source: fname
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: ftitle
                        text: "Figma"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            CricleComponent {
                width: 140
                rotation: -30
                x: 40
                y: 80
                Row {
                    rotation: 30
                    spacing: 6
                    width: qname.width + qtitle.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: qname
                        text: "Q"
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: qname
                            start: Qt.point(0, 0)
                            end: Qt.point(qname.width, 0)
                            source: qname
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: qtitle
                        text: "qcreator"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            CricleComponent {
                width: 140
                rotation: -60
                x: 0
                y: 230
                Row {
                    rotation: 60
                    spacing: 6
                    width: qmlname.width + qmltitle.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: qmlname
                        text: "Q"
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: qmlname
                            start: Qt.point(0, 0)
                            end: Qt.point(qmlname.width, 0)
                            source: qmlname
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: qmltitle
                        text: "qml"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            CricleComponent {
                width: 140
                rotation: -30
                x: 40
                y: 380
                Row {
                    rotation: 30
                    spacing: 6
                    width: cname.width + ctitle.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: cname
                        text: "C"
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: cname
                            start: Qt.point(0, 0)
                            end: Qt.point(cname.width, 0)
                            source: cname
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: ctitle
                        text: "cmake"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            CricleComponent {
                width: 140
                x: 130
                y: 380 + 130
                Row {
                    spacing: 6
                    width: gname.width + gtitle.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: gname
                        text: "G"
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: gname
                            start: Qt.point(0, 0)
                            end: Qt.point(gname.width, 0)
                            source: gname
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: gtitle
                        text: "gitee"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            Rectangle {
                id: line1
                width: 60
                height: 40
                x: 190
                y: 300
                LinearGradient {
                    anchors.fill: line1
                    start: Qt.point(0, 0)
                    end: Qt.point(line1.width, line1.height)
                    source: line1
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: UTheme.base}
                        GradientStop { position: 1.0; color: UTheme.highlight}
                    }
                }
            }

            CricleComponent {
                width: 240
                x: 270
                y: 200
                Text {
                    z: 0
                    text: qsTr("2D")
                    anchors.centerIn: parent
                    font.pixelSize: 120
                    font.bold: true
                    font.family: "Microsoft Yahei"
                    color: qmlHelper.colorAlpha(UTheme.text, 20)
                }

                Row {
                    z: 10
                    spacing: 6
                    width: name.width + title.width + 10
                    anchors.centerIn: parent
                    Text {
                        id: name
                        text: "U"
                        font.pixelSize: 40
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        anchors.verticalCenter: parent.verticalCenter
                        LinearGradient {
                            anchors.fill: name
                            start: Qt.point(0, 0)
                            end: Qt.point(name.width, 0)
                            source: name
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 0, 1)}
                                GradientStop { position: 0.5 ; color: Qt.rgba(0, 1, 0, 1)}
                                GradientStop { position: 1.0; color: Qt.rgba(0, 1, 1, 1)}
                            }
                        }
                    }
                    Text {
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Microsoft Yahei"
                        id: title
                        text: "Union"
                        anchors.verticalCenter: parent.verticalCenter
                        color: UTheme.text
                    }
                }
            }

            Rectangle {
                id: line2
                x: 525
                y: 300
                width: 60
                height: 40
                LinearGradient {
                    anchors.fill: line2
                    start: Qt.point(0, 0)
                    end: Qt.point(line2.width, line2.height)
                    source: line2
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: UTheme.base}
                        GradientStop { position: 1.0; color: UTheme.highlight}
                    }
                }
            }

            Rectangle {
                id: openSource
                x: 600
                y: 220
                width: 206
                height: width
                radius: width / 2
                LinearGradient {
                    anchors.fill: openSource
                    start: Qt.point(0, 0)
                    end: Qt.point(openSource.width, openSource.height)
                    source: openSource
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: UTheme.base}
                        GradientStop { position: 1.0; color: UTheme.highlight}
                    }
                }
                Text {
                    font.pixelSize: 30
                    font.bold: true
                    font.family: "Microsoft Yahei"
                    text: "OpenSource"
                    anchors.centerIn: parent
                    color: UTheme.text
                }
            }
        }

        Label {
            font.pixelSize: 20
            font.bold: true
            color: UTheme.text
            text: qsTr("欢迎加入")
        }
        Label {
            width: scrollView.width - 40
            font.pixelSize: 14
            color: UTheme.text
            text: qsTr("       对外开源，Union-2D希望将范围扩大至其他人员，大家一起交流和开发，以便持续打磨完善组件库和相关产品。期待你的参与！")
            wrapMode: Text.WordWrap
        }
        ULinkButton {
            id: generalButton
            text: qsTr("开源仓库")
            onClicked: Qt.openUrlExternally("https://gitee.com/uthelei/Union-2D/tree/develop")
        }
        Item {
            width: 100
            height: 30
        }
    }
}
