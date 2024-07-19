import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import "../controls"
import utk.model 1.0

Item {
    property var listWidget: [accountWidget]
    property var listMap: {"0": accountWidget}

    Rectangle {
        id: leftRectangle
        color: UTheme.base
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width/5
        radius: 8
        ListModel {
            id: leftModel
            ListElement {
                itemData: 0
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("组件总览")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("基础")
                sourceUrl: ""
            }
            ListElement {
                itemData: 1
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Button 按钮")
                sourceUrl: ""
            }
            ListElement {
                itemData: 2
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Icon 图标")
                sourceUrl: ""
            }
            ListElement {
                itemData: 3
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Link 按钮")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("布局")
                sourceUrl: ""
            }
            ListElement {
                itemData: 4
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Grid 栅格")
                sourceUrl: ""
            }
            ListElement {
                itemData: 5
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Layout 布局")
                sourceUrl: ""
            }
            ListElement {
                itemData: 6
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Space 间距")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("导航")
                sourceUrl: ""
            }
            ListElement {
                itemData: 7
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Anchor 锚点")
                sourceUrl: ""
            }
            ListElement {
                itemData: 8
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Dropdown 下拉菜单")
                sourceUrl: ""
            }
            ListElement {
                itemData: 9
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Menu 导航菜单")
                sourceUrl: ""
            }
            ListElement {
                itemData: 10
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Pagination 分页")
                sourceUrl: ""
            }
            ListElement {
                itemData: 11
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Steps 步骤条")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("输入")
                sourceUrl: ""
            }
            ListElement {
                itemData: 12
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("ComboBox 组合框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 13
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Checkbox 多选框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 14
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("ColorPicker 颜色选择器")
                sourceUrl: ""
            }
            ListElement {
                itemData: 15
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("DatePicker 日期选择")
                sourceUrl: ""
            }
            ListElement {
                itemData: 16
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Input 输入框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 17
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("SpinBox 数字框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 18
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Radio 单选框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 19
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Rate 评分")
                sourceUrl: ""
            }
            ListElement {
                itemData: 20
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Slider 滑块")
                sourceUrl: ""
            }
            ListElement {
                itemData: 21
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Switch 开关")
                sourceUrl: ""
            }
            ListElement {
                itemData: 22
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Transfer 穿梭框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 23
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("TextEdit 多行文本框")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("数据展示")
                sourceUrl: ""
            }
            ListElement {
                itemData: 24
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Avatar 头像")
                sourceUrl: ""
            }
            ListElement {
                itemData: 25
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Badge 徽标数")
                sourceUrl: ""
            }
            ListElement {
                itemData: 26
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Calendar 日历")
                sourceUrl: ""
            }
            ListElement {
                itemData: 27
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Card 卡片")
                sourceUrl: ""
            }
            ListElement {
                itemData: 28
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Collapse 折叠面板")
                sourceUrl: ""
            }
            ListElement {
                itemData: 29
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Image 图片")
                sourceUrl: ""
            }
            ListElement {
                itemData: 30
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("List 列表")
                sourceUrl: ""
            }
            ListElement {
                itemData: 31
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Loading 加载")
                sourceUrl: ""
            }
            ListElement {
                itemData: 32
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Progress 进度条")
                sourceUrl: ""
            }
            ListElement {
                itemData: 33
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Swiper 轮播框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 34
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Table 表格")
                sourceUrl: ""
            }
            ListElement {
                itemData: 35
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Tag 标签")
                sourceUrl: ""
            }
            ListElement {
                itemData: 36
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Timeline 时间轴")
                sourceUrl: ""
            }
            ListElement {
                itemData: 37
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Tooltip 提示")
                sourceUrl: ""
            }
            ListElement {
                itemData: 38
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Tree 树")
                sourceUrl: ""
            }
            ListElement {
                itemData: -1
                itemRole: UListView.ItemRoles.Group
                itemName: qsTr("消息提醒")
                sourceUrl: ""
            }
            ListElement {
                itemData: 39
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Alert 警告")
                sourceUrl: ""
            }
            ListElement {
                itemData: 40
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Dialog 对话框")
                sourceUrl: ""
            }
            ListElement {
                itemData: 41
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Drawer 抽屉")
                sourceUrl: ""
            }
            ListElement {
                itemData: 42
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Message 全局提示")
                sourceUrl: ""
            }
            ListElement {
                itemData: 43
                itemRole: UListView.ItemRoles.Member
                itemName: qsTr("Result 结果")
                sourceUrl: ""
            }
        }
        UListView {
            id: listView
            anchors.fill: parent
            model: leftModel
            itemColor: "transparent"
            iconVisible: false
            clip: true
            onCurrentIndexChanged: rightRectangle.setCurrentIndex(currentIndex)
            leftMargin: 10
            rightMargin: 10
            topMargin: 10
            bottomMargin: 10
            onHoverChanged: {edgeButton.visible = isHovered}
            fontSize: 14
        }
        NumberAnimation on width { id: animation; to: 0; duration: 500; running: false}
        NumberAnimation on width { id: animation1; to: parent.width/5; duration: 500; running: false}
    }

    UEdgeButton {
        id: edgeButton
        width: 10
        height: 80
        visible: false
        anchors.left: leftRectangle.right
        anchors.verticalCenter: leftRectangle.verticalCenter
        onExpandStatusChanged : {
            if (isExpand) {
                animation1.start()
            } else {
                animation.start()
            }
        }
    }

    Rectangle {
        id: rightRectangle
        anchors.left: edgeButton.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        color: UTheme.base
        radius: 8

        OverviewWidget {
            id: accountWidget
            anchors.fill: parent
            anchors.margins: 30
            visible: true
        }

        function setCurrentIndex(index) {
        }
    }

    function setCurrentItem(index) {
        listView.currentIndex = index
    }
}
