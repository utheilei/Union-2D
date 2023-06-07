#ifndef QMLHELPER_H
#define QMLHELPER_H

#include <QJsonArray>
#include <QObject>
#include <QRectF>

class QmlHelper : public QObject
{
    Q_OBJECT

public:
    enum TagCursorCtrlStyle
    {
        CursorNormal = 0,    // 普通鼠标
        CursorTopLeft,
        CursorTop,
        CursorTopRight,
        CursorLeft,
        CursorBottomLeft,
        CursorBottom,
        CursorBottomRight,
        CursorRight
    };
    Q_ENUM(TagCursorCtrlStyle)

    explicit QmlHelper(QObject* parent = nullptr);

    Q_INVOKABLE bool contains(QRectF rect, QPointF point);

    Q_INVOKABLE QRectF changeGeometry(QRectF rect, QPointF point, int cursorCtrlStyle);

    Q_INVOKABLE QJsonArray listModel();

signals:

public slots:

private:
};

#endif // QMLHELPER_H
