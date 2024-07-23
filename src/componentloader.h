#ifndef COMPONENTLOADER_H
#define COMPONENTLOADER_H

#include <QQmlComponent>
#include <QQmlEngine>

class ComponentLoader : public QObject
{
    Q_OBJECT

public:
    explicit ComponentLoader(QObject* parent = nullptr);

    Q_INVOKABLE QString loadFile(const QString &filePath);

    Q_INVOKABLE void setData(const QString &data);

    Q_INVOKABLE QObject* create(QObject* parent = nullptr);

signals:
    void componentChanged();

private:
    QSharedPointer<QQmlComponent> m_component = nullptr;
    QObject* m_currentObject = nullptr;
    QQmlEngine m_engine;
};

#endif // COMPONENTLOADER_H
