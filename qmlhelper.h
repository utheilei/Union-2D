#ifndef QMLHELPER_H
#define QMLHELPER_H

#include <QJsonArray>
#include <QObject>
#include <QRectF>

class QmlHelper : public QObject
{
    Q_OBJECT

public:
    explicit QmlHelper(QObject* parent = nullptr);

    Q_INVOKABLE bool contains(QRectF rect, QPointF point);

    Q_INVOKABLE QJsonArray listModel();

    Q_INVOKABLE QString dayOfWeek(int index, int format);
};

#endif // QMLHELPER_H
