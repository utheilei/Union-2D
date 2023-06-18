#include "qmlhelper.h"

#include <QDebug>
#include <QGuiApplication>
#include <QTranslator>

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
    QTranslator translator;
    if (QLocale::Language::Chinese == language) {
        translator.load(qApp->applicationDirPath() + "/translation/language_zh_CN.qm");
    } else if (QLocale::Language::English == language) {
        translator.load(qApp->applicationDirPath() + "/translation/language_en.qm");
    }
    qApp->installTranslator(&translator);
    emit languageChanged();
}
