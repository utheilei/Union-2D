#ifndef COMPONENTLOADER_H
#define COMPONENTLOADER_H

#include <QQmlComponent>

class ComponentLoader : public QObject
{
    Q_OBJECT

public:
    explicit ComponentLoader(QQmlEngine *engine, QObject* parent = nullptr);

    Q_INVOKABLE QString loadFile(const QString &filePath);

    Q_INVOKABLE void setData(const QString &data);

    Q_INVOKABLE QObject *create(QObject *parent = nullptr);

signals:
    void componentChanged();

private:
    QSharedPointer<QQmlComponent> m_component = nullptr;
    QObject *m_currentObject = nullptr;
    QQmlEngine *m_engine = nullptr;
};

#endif // COMPONENTLOADER_H
