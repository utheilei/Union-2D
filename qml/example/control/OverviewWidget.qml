import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import utk.model 1.0
import "../../controls"

ScrollView {
    id: scrollView
    clip: true
    Column {
        anchors.fill: parent
        spacing: 10
        Label {
            id: titleLabel
            font.pixelSize: 24
            font.bold: true
            color: UTheme.text
            text: qsTr("组件总览")
        }

        Label {
            id: describeLabel
            width: scrollView.width
            font.pixelSize: 14
            color: UTheme.text
            wrapMode: Text.WordWrap
            text: qsTr("       为客户端应用提供了丰富的基础UI组件，常用控件可以分为基础控件、布局控件、导航控件、输入控件、数据展示控件以及消息提示控件，用户通过合理选择和组合这些控件，可以创建出功能强大、易于使用的用户界面")
        }

        USearchLineEdit {
            id: searchLineEdit
            width: scrollView.width
            height: 36
            onEditTextChanged: {
                commonView.model.setFilterFixedString(searchLineEdit.text)
                layoutView.model.setFilterFixedString(searchLineEdit.text)
                navigationView.model.setFilterFixedString(searchLineEdit.text)
                inputView.model.setFilterFixedString(searchLineEdit.text)
                dataView.model.setFilterFixedString(searchLineEdit.text)
                messageView.model.setFilterFixedString(searchLineEdit.text)
            }
        }

        ControlsListView {
            id: commonView
            width: scrollView.width
            height: Math.ceil(3 / Math.floor(width / 236)) * 180
            title: qsTr("通用")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var buttonMap = {"iconName": "button", "itemName": "Button 按钮"}
                var iconMap = {"iconName": "about", "itemName": "Icon 图标"}
                var linkMap = {"iconName": "linkbutton", "itemName": "Link 按钮"}
                modelData = [[buttonMap],[iconMap],[linkMap]]
            }
            onItemClicked: {
                console.log(index, name)
                controlsWidget.setCurrentItem(index + 2)
            }
        }

        ControlsListView {
            id: layoutView
            width: scrollView.width
            height: Math.ceil(3 / Math.floor(width / 226)) * 180
            title: qsTr("布局")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var buttonMap = {"iconName": "about", "itemName": "Grid 栅格"}
                var iconMap = {"iconName": "about", "itemName": "Layout 布局"}
                var linkMap = {"iconName": "about", "itemName": "Flow 流式布局"}
                modelData = [[buttonMap],[iconMap],[linkMap]]
            }
            onItemClicked: {console.log(index, name)}
        }

        ControlsListView {
            id: navigationView
            width: scrollView.width
            height: Math.ceil(5 / Math.floor(width / 226)) * 180
            title: qsTr("导航")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var map = {"iconName": "about", "itemName": "Anchor 锚点"}
                var map1 = {"iconName": "about", "itemName": "Dropdown 下拉菜单"}
                var map2 = {"iconName": "about", "itemName": "Menu 导航菜单"}
                var map3 = {"iconName": "about", "itemName": "Pagination 分页"}
                var map4 = {"iconName": "about", "itemName": "Steps 步骤条"}
                modelData = [[map],[map1],[map2],[map3],[map4]]
            }
            onItemClicked: {console.log(index, name)}
        }

        ControlsListView {
            id: inputView
            width: scrollView.width
            height: Math.ceil(12 / Math.floor(width / 226)) * 180
            title: qsTr("输入")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var map = {"iconName": "about", "itemName": "ComboBox 组合框"}
                var map1 = {"iconName": "about", "itemName": "Checkbox 多选框"}
                var map2 = {"iconName": "about", "itemName": "ColorPicker 颜色选择器"}
                var map3 = {"iconName": "about", "itemName": "DatePicker 日期选择"}
                var map4 = {"iconName": "about", "itemName": "Input 输入框"}
                var map5 = {"iconName": "about", "itemName": "SpinBox 数字框"}
                var map6 = {"iconName": "about", "itemName": "Radio 单选框"}
                var map7 = {"iconName": "about", "itemName": "Rate 评分"}
                var map8 = {"iconName": "about", "itemName": "Slider 滑块"}
                var map9 = {"iconName": "about", "itemName": "Switch 开关"}
                var map10 = {"iconName": "about", "itemName": "Transfer 穿梭框"}
                var map11 = {"iconName": "about", "itemName": "TextEdit 多行文本框"}
                modelData = [[map],[map1],[map2],[map3],[map4],[map5],[map6],[map7],[map8],[map9],[map10],[map11]]
            }
            onItemClicked: {console.log(index, name)}
        }

        ControlsListView {
            id: dataView
            width: scrollView.width
            height: Math.ceil(15 / Math.floor(width / 226)) * 180
            title: qsTr("数据展示")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var map = {"iconName": "about", "itemName": "Avatar 头像"}
                var map1 = {"iconName": "about", "itemName": "Badge 徽标数"}
                var map2 = {"iconName": "about", "itemName": "Calendar 日历"}
                var map3 = {"iconName": "about", "itemName": "Card 卡片"}
                var map4 = {"iconName": "about", "itemName": "Collapse 折叠面板"}
                var map5 = {"iconName": "about", "itemName": "Image 图片"}
                var map6 = {"iconName": "about", "itemName": "List 列表"}
                var map7 = {"iconName": "about", "itemName": "Loading 加载"}
                var map8 = {"iconName": "about", "itemName": "Progress 进度条"}
                var map9 = {"iconName": "about", "itemName": "Swiper 轮播框"}
                var map10 = {"iconName": "about", "itemName": "Table 表格"}
                var map11 = {"iconName": "about", "itemName": "Tag 标签"}
                var map12 = {"iconName": "about", "itemName": "Timeline 时间轴"}
                var map13 = {"iconName": "about", "itemName": "Tooltip 提示"}
                var map14 = {"iconName": "about", "itemName": "Tree 树"}
                modelData = [[map],[map1],[map2],[map3],[map4],[map5],[map6],[map7],[map8],[map9],[map10],[map11],[map12],[map13],[map14]]
            }
            onItemClicked: {console.log(index, name)}
        }

        ControlsListView {
            id: messageView
            width: scrollView.width
            height: Math.ceil(5 / Math.floor(width / 226)) * 180
            title: qsTr("消息提醒")
            Component.onCompleted: {
                model.horHeader = ["111"]
                model.insertRoleName(1257, "iconName");
                model.insertRoleName(1258, "itemName");
                var map = {"iconName": "about", "itemName": "Alert 警告"}
                var map1 = {"iconName": "about", "itemName": "Dialog 对话框"}
                var map2 = {"iconName": "about", "itemName": "Drawer 抽屉"}
                var map3 = {"iconName": "about", "itemName": "Message 全局提示"}
                var map4 = {"iconName": "about", "itemName": "Result 结果"}
                modelData = [[map],[map1],[map2],[map3],[map4]]
            }
            onItemClicked: {console.log(index, name)}
        }
    }
}
