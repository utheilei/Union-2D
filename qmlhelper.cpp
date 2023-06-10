#include "qmlhelper.h"

#include <QDebug>

QmlHelper::QmlHelper(QObject* parent) : QObject(parent)
{
}

bool QmlHelper::contains(QRectF rect, QPointF point)
{
    return rect.contains(point);
}

QJsonArray QmlHelper::listModel()
{
    QJsonArray list;
    list.append(QJsonArray() << "ButtonWidgets" << "qrc:/image/button.svg");
    list.append(QJsonArray() << "InputWidgets" << "qrc:/image/inputedit.svg");
    list.append(QJsonArray() << "ProgressWidgets" << "qrc:/image/progress.svg");
    list.append(QJsonArray() << "DialogWidgets" << "qrc:/image/dialog.svg");
    list.append(QJsonArray() << "TooltipWidgets" << "qrc:/image/tooltip.svg");
    return list;
}
