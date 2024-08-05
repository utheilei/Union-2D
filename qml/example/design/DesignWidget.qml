import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import utk.model 1.0
import QtGraphicalEffects 1.0
import "../../controls"

Item {
    id: designWidget
    property var widgetMap: {"1":"0", "2":"1", "4":"2", "5":"3", "6":"4", "7":"5", "8":"6", "9":"7", "10":"8"}
    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        UTreeNavigationBar {
            id: bar
            Layout.preferredWidth: 310
            Layout.fillHeight: true
            Component.onCompleted: {
                bar.treeViewModel.insertItems(0, [["Union-2D", ""],["样式", ""],["设计原则", ""],["动效", ""]])
                bar.treeViewModel.insertItems(0, [["介绍", ""],["更新日志", ""]], bar.treeViewModel.index(0, 0))
                bar.treeViewModel.insertItems(0, [["主题", ""],["颜色", ""],["字体", ""],["布局", ""],["阴影", ""],["光晕", ""],["模糊", ""]], bar.treeViewModel.index(1, 0))
                bar.treeViewModel.treeExpandAll()
                bar.setCurrentIndex(bar.treeViewModel.index(0, 0, bar.treeViewModel.index(0, 0)))
            }
            onItemClicked: {
                var index = widgetMap[row]
                if (typeof index === "undefined") {
                    console.info(index + " undefined")
                    return
                }
                layout.currentIndex = Number(index)
            }
        }

        Rectangle {
            Layout.fillHeight: true
            width: 1
            color: UTheme.frameBorder
        }

        StackLayout {
            id: layout
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: 0
            IntroduceWidget {}
            SoftwareLogWidget {}
            ThemeWidget {
                onThemeChanged: {UTheme.applicationTheme = index}
                onHighlightChanged: {UTheme.setHighlightColor(color);UTheme.highlight = color}
            }
            ColorWidget {}
            Item {}
            LayoutWidget {}
            DropShadowWidget {}
            GlowWidget {}
            BlurWidget {}
        }
    }
}
