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
    ~QmlHelper();

    Q_INVOKABLE bool isImageValid(const QUrl &url);

    Q_INVOKABLE bool contains(QRectF rect, QPointF point);

    Q_INVOKABLE QJsonArray softwareLogs();

    Q_INVOKABLE QString dayOfWeek(int index, int format);

    Q_INVOKABLE void setTranslator(int language);

    Q_INVOKABLE QString appPath();

    Q_INVOKABLE QString colorName(const QColor &color);

    Q_INVOKABLE QColor colorAlpha(const QColor &color, int alpha);

    Q_INVOKABLE QList<QList<QVariantMap>> loadClassProperty(const QString &className);

    Q_INVOKABLE void clipboardCopy(const QString &text);

    Q_INVOKABLE QString removeSpecialCharacters(const QString &str);

signals:
    void languageChanged();

private:
    QLocale::Language m_language = QLocale::Chinese;
};

#endif // QMLHELPER_H
