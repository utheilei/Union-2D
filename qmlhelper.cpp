#include "qmlhelper.h"

#include <QDebug>

QmlHelper::QmlHelper(QObject* parent) : QObject(parent)
{
}

bool QmlHelper::contains(QRectF rect, QPointF point)
{
    return rect.contains(point);
}

QRectF QmlHelper::changeGeometry(QRectF rect, QPointF point, int cursorCtrlStyle)
{
    qInfo() << rect << point << cursorCtrlStyle;
    switch (cursorCtrlStyle)
    {
        case CursorTopLeft:
            rect.setTopLeft(rect.topLeft() + point);
            break;
        case CursorTop:
            rect.setTop(rect.top() + point.y());
            break;
        case CursorTopRight:
            rect.setTopRight(rect.topRight() + point);
            break;
        case CursorLeft:
            rect.setLeft(rect.left() + point.x());
            break;
        case CursorBottomLeft:
            rect.setBottomLeft(rect.bottomLeft() + point);
            break;
        case CursorBottom:
            rect.setBottom(rect.bottom() + point.y());
            break;
        case CursorBottomRight:
            rect.setBottomRight(rect.bottomRight() + point);
            break;
        case CursorRight:
            rect.setRight(rect.right() + point.x());
            break;
        default:
            break;
    }

    return rect;
}

QJsonArray QmlHelper::listModel()
{
    QJsonArray list;
    list.append(QJsonArray() << "帐户" << "qrc:/icon/dcc_nav_accounts_84px.svg");
    list.append(QJsonArray() << "Union ID" << "qrc:/icon/dcc_nav_cloudsync_84px.svg");
    list.append(QJsonArray() << "显示" << "qrc:/icon/dcc_nav_display_84px.svg");
    list.append(QJsonArray() << "默认程序" << "qrc:/icon/dcc_nav_defapp_84px.svg");
    list.append(QJsonArray() << "个性化" << "qrc:/icon/dcc_nav_personalization_84px.svg");
    list.append(QJsonArray() << "网络" << "qrc:/icon/dcc_nav_network_84px.svg");
    list.append(QJsonArray() << "通知" << "qrc:/icon/dcc_nav_unionid_84px.svg");
    list.append(QJsonArray() << "声音" << "qrc:/icon/dcc_nav_sound_84px.svg");
    list.append(QJsonArray() << "时间日期" << "qrc:/icon/dcc_nav_datetime_84px.svg");
    list.append(QJsonArray() << "电源管理" << "qrc:/icon/dcc_nav_power_84px.svg");
    list.append(QJsonArray() << "鼠标" << "qrc:/icon/dcc_nav_mouse_84px.svg");
    list.append(QJsonArray() << "键盘和显示" << "qrc:/icon/dcc_nav_keyboard_84px.svg");
    list.append(QJsonArray() << "辅助功能" << "qrc:/icon/dcc_nav_bluetooth_84px.svg");
    list.append(QJsonArray() << "更新" << "qrc:/icon/dcc_nav_update_84px.svg");
    list.append(QJsonArray() << "系统信息" << "qrc:/icon/dcc_nav_systeminfo_84px.svg");
    list.append(QJsonArray() << "通用" << "qrc:/icon/dcc_nav_commoninfo_84px.svg");

    return list;
}
