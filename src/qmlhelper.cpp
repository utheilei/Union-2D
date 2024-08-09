#include "qmlhelper.h"

#include <QColor>
#include <QDebug>
#include <QGuiApplication>
#include <QTranslator>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QGuiApplication>
#include <QClipboard>
#include <QRegExp>

QmlHelper::QmlHelper(QObject* parent) : QObject(parent)
{
}

QmlHelper::~QmlHelper()
{
}

bool QmlHelper::isImageValid(const QUrl &url)
{
    QString fileName = url.toString();
    if (fileName.startsWith("qrc"))
    {
        fileName.remove("qrc");
    }
    return QFile::exists(fileName);
}

bool QmlHelper::contains(QRectF rect, QPointF point)
{
    return rect.contains(point);
}

QJsonArray QmlHelper::softwareLogs()
{
    QJsonArray result;
    QFile file(QString("%1/updatelog/softwarelog.json").arg(qApp->applicationDirPath()));
    if (!file.open(QFile::ReadOnly))
    {
        qCritical() << "file open failed:" << file.errorString();
        return result;
    }

    QJsonParseError jsonError;
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll(), &jsonError);
    if (QJsonParseError::NoError != jsonError.error)
    {
        qCritical() << "Json load failed:" << jsonError.errorString();
        return result;
    }
    return doc.array();
}

QString QmlHelper::dayOfWeek(int index, int format)
{
    QString week = "";
    switch (index)
    {
        case 0:
        {
            if (0 == format)
            {
                week = "Monday";
            }
            else if (1 == format)
            {
                week = "Mon";
            }
            else if (2 == format)
            {
                week = "M";
            }
            break;
        }
        case 1:
        {
            if (0 == format)
            {
                week = "Tuesday";
            }
            else if (1 == format)
            {
                week = "Tue";
            }
            else if (2 == format)
            {
                week = "T";
            }
            break;
        }
        case 2:
        {
            if (0 == format)
            {
                week = "Wednesday";
            }
            else if (1 == format)
            {
                week = "Wed";
            }
            else if (2 == format)
            {
                week = "W";
            }
            break;
        }
        case 3:
        {
            if (0 == format)
            {
                week = "Thursday";
            }
            else if (1 == format)
            {
                week = "Thu";
            }
            else if (2 == format)
            {
                week = "T";
            }
            break;
        }
        case 4:
        {
            if (0 == format)
            {
                week = "Friday";
            }
            else if (1 == format)
            {
                week = "Fri";
            }
            else if (2 == format)
            {
                week = "F";
            }
            break;
        }
        case 5:
        {
            if (0 == format)
            {
                week = "Saturday";
            }
            else if (1 == format)
            {
                week = "Sat";
            }
            else if (2 == format)
            {
                week = "S";
            }
            break;
        }
        case 6:
        {
            if (0 == format)
            {
                week = "Sunday";
            }
            else if (1 == format)
            {
                week = "Sun";
            }
            else if (2 == format)
            {
                week = "S";
            }
            break;
        }
        default:
            break;
    }

    return week;
}

void QmlHelper::setTranslator(int language)
{
    if (m_language == language)
        return;

    m_language = QLocale::Language(language);
    QTranslator translator;
    if (QLocale::Language::Chinese == language)
    {
        translator.load(qApp->applicationDirPath() + "/translation/language_zh_CN.qm");
    }
    else if (QLocale::Language::English == language)
    {
        translator.load(qApp->applicationDirPath() + "/translation/language_en.qm");
    }
    qApp->installTranslator(&translator);
    emit languageChanged();
}

QString QmlHelper::appPath()
{
    return qApp->applicationDirPath();
}

QString QmlHelper::colorName(const QColor &color)
{
    return color.name();
}

QColor QmlHelper::colorAlpha(const QColor &color, int alpha)
{
    QColor col(color);
    col.setAlpha(alpha);
    return col;
}

QList<QList<QVariantMap>> QmlHelper::loadClassProperty(const QString &className)
{
    QList<QList<QVariantMap>> result;
    QFile file(QString("%1/configs/%2.json").arg(qApp->applicationDirPath()).arg(className));
    if (!file.open(QFile::ReadOnly))
    {
        qCritical() << "file open failed:" << file.errorString();
        return result;
    }

    QJsonParseError jsonError;
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll(), &jsonError);
    if (QJsonParseError::NoError != jsonError.error)
    {
        qCritical() << "Json load failed:" << jsonError.errorString();
        return result;
    }

    auto apiArray = doc.object()["api"].toArray();
    if (apiArray.isEmpty())
    {
        return result;
    }

    for (const auto &value : apiArray)
    {
        QList<QVariantMap> rowList;
        QVariantMap map;
        map.insert("property", value.toObject()["property"].toVariant());
        map.insert("note", value.toObject()["note"].toVariant());
        map.insert("type", value.toObject()["type"].toVariant());
        map.insert("default", value.toObject()["default"].toVariant());
        rowList.append(map);
        rowList.append(map);
        rowList.append(map);
        rowList.append(map);
        result.append(rowList);
    }
    return result;
}

void QmlHelper::clipboardCopy(const QString &text)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    qDebug() << "clipboardCopy:" << text;
    clipboard->setText(text);
}

QString QmlHelper::removeSpecialCharacters(const QString &str)
{
    QString result = str;
    QRegExp rx("[^a-zA-Z0-9\u4e00-\u9fa5]");
    result.replace(rx, "");
    return result;
}
