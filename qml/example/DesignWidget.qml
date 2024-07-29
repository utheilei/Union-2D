import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15
import "../controls"
import utk.model 1.0
import QtGraphicalEffects 1.0

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
                bar.treeViewModel.insertItems(0, [["介绍", ""]], bar.treeViewModel.index(0, 0))
                bar.treeViewModel.insertItems(0, [["主题", ""],["颜色", ""],["字体", ""],["布局", ""],["阴影", ""]], bar.treeViewModel.index(1, 0))
                bar.treeViewModel.treeExpandAll()
                bar.setCurrentIndex(bar.treeViewModel.index(0, 0, bar.treeViewModel.index(1, 0)))
            }
            onItemClicked: {
                switch (row) {
                case 1:
                    break
                case 3:
                    layout.currentIndex = 1
                    break
                case 6:
                    layout.currentIndex = 2
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
            currentIndex: 1
            Rectangle {
                color: 'red'
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            ThemeWidget {
                Layout.fillWidth: true
                Layout.fillHeight: true
                onThemeChanged: {UTheme.applicationTheme = index}
                onHighlightChanged: {UTheme.setHighlightColor(color);UTheme.highlight = color}
            }
            LayoutWidget {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
