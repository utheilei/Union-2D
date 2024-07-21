#include "componentloader.h"

#include <QFile>

ComponentLoader::ComponentLoader(QQmlEngine *engine, QObject *parent) : QObject(parent)
{
    m_engine = engine;
}

QString ComponentLoader::loadFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.exists()) {
        qWarning() << "file not exists:" << filePath;
        return QString();
    }

    if (!file.open(QFile::ReadOnly)) {
        qWarning() << file.error() << file.errorString();
        return QString();
    }

    return file.readAll();
}

void ComponentLoader::setData(const QString &data)
{
    if (data.isEmpty()) {
        return;
    }
    m_component.reset(new QQmlComponent(m_engine));
    connect(m_component.get(), &QQmlComponent::statusChanged, this, [this](QQmlComponent::Status status){
        if (QQmlComponent::Status::Ready == status) {
            emit componentChanged();
        }
    });
    m_component->setData(data.toUtf8(), QUrl());
}

QObject *ComponentLoader::create(QObject *parent)
{
    if (nullptr != m_currentObject) {
        m_currentObject->deleteLater();
        m_currentObject = nullptr;
    }

    m_currentObject = m_component->create();
    if (nullptr == m_currentObject) {
        return nullptr;
    }
    return m_currentObject;
}
