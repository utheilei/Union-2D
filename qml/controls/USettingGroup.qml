import QtQuick 2.7
import QtQuick.Controls 2.4

ListView {
    id: view
    property int itemHeight: 46
    property int itemRadius: 10
    property color itemColor: UTheme.itemBackground
    spacing: 5
    delegate: listDelegate
    height: count * itemHeight

    Component {
        id: listDelegate
        USettingItem {
            width: view.width - leftMargin - rightMargin
            height: itemHeight
            radius: itemRadius
            itemPosition: getItemPosition(index)
            itemColor: view.itemColor
            itemText: text
            itemIcon: "qrc:/icon/" + UTheme.themeName + "/" + iconName + ".svg"
        }
    }

    function getItemPosition(index) {
        var count = view.count;
        if (count > 1) {
            switch(index) {
            case 0:
                return URadiusRectangle.ItemPosition.BottomLeft | URadiusRectangle.ItemPosition.BottomRight
            case count - 1:
                return URadiusRectangle.ItemPosition.TopLeft | URadiusRectangle.ItemPosition.TopRight
            default:
                return URadiusRectangle.ItemPosition.All
            }
        } else {
            return 0
        }
    }
}
