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

    Q_INVOKABLE void setTranslator(int language);

    Q_INVOKABLE QString appPath();

    Q_INVOKABLE QString colorName(const QColor &color);

    Q_INVOKABLE QColor colorAlpha(const QColor &color, int alpha);

    Q_INVOKABLE QList<QList<QVariantMap>> loadClassProperty(const QString &className);

signals:
    void languageChanged();

private:
    QLocale::Language m_language = QLocale::Chinese;
};

#endif // QMLHELPER_H
