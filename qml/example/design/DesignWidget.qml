import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import utk.model 1.0
import QtGraphicalEffects 1.0
import "../../controls"

Item {
    id: designWidget
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
                switch (row) {
                case 1:
                    layout.currentIndex = 0
                    break
                case 2:
                    layout.currentIndex = 6
                    break
                case 4:
                    layout.currentIndex = 1
                    break
                case 7:
                    layout.currentIndex = 2
                    break
                case 8:
                    layout.currentIndex = 3
                    break
                case 9:
                    layout.currentIndex = 4
                    break
                case 10:
                    layout.currentIndex = 5
                    break
                default:
                    break
                }
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
            ThemeWidget {
                onThemeChanged: {UTheme.applicationTheme = index}
                onHighlightChanged: {UTheme.setHighlightColor(color);UTheme.highlight = color}
            }
            LayoutWidget {}
            DropShadowWidget {}
            GlowWidget {}
            BlurWidget {}
            SoftwareLogWidget {}
        }
    }
}
