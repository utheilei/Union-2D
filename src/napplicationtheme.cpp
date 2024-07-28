#include "napplicationtheme.h"

#include <QDomDocument>
#include <QFile>
#include <QColor>
#include <QDir>
#include <QApplication>
#include <QStandardPaths>
#include <QSettings>
#include <QDebug>

struct DPaletteData : public QSharedData
{
    QMap<int, QMap<int, QColor>> brushMap;
};

class UApplicationThemePrivate
{
    Q_DECLARE_PUBLIC(UApplicationTheme)
public:
    UApplicationThemePrivate(UApplicationTheme* parent) : q_ptr(parent)
    {
    }
    ~UApplicationThemePrivate() {}

    QString mkMutiDir(const QString &path);

    void initPaletteData();

    bool parseTheme();

    bool parseGeneralTheme(int &theme, const QDomElement &dom);

    bool parsePalette(int &theme, const QDomElement &dom);

    QSharedDataPointer<DPaletteData> data;
    UApplicationTheme* q_ptr = nullptr;
    QString themeName = "light";
    int applicationTheme = UApplicationTheme::LightTheme;
    int applicationLanguage = QLocale::Chinese;
    QMap<int, QString> themeMap;
};

QString UApplicationThemePrivate::mkMutiDir(const QString &path)
{
    QString tempPath = path;
    tempPath.replace("\\", "/");
    QDir dir(path);
    if (dir.exists(path))
    {
        return path;
    }
    QString parentDir = mkMutiDir(path.mid(0, path.lastIndexOf('/')));
    QString dirname = path.mid(path.lastIndexOf('/') + 1);
    QDir parentPath(parentDir);
    if (!dirname.isEmpty())
        parentPath.mkpath(dirname);
    return parentDir + "/" + dirname;
}

void UApplicationThemePrivate::initPaletteData()
{
    Q_Q(UApplicationTheme);
    QString AppDataLocation = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    mkMutiDir(AppDataLocation);

    QString fileName = QString("%1/%2.ini").
                       arg(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)).arg(qApp->applicationName());

    data = QSharedDataPointer<DPaletteData>(new DPaletteData());
    parseTheme();
    if (!QFile::exists(fileName))
    {
        QSettings settings(fileName, QSettings::IniFormat);
        settings.setValue("Settings/Theme", UApplicationTheme::LightTheme);
        settings.setValue("Settings/Language", QLocale::Chinese);
        settings.sync();
    }
    else
    {
        applicationTheme = q->applicationTheme();
        themeName = applicationTheme > 1 ? "light" : themeMap[applicationTheme];
        applicationLanguage = q->applicationLanguage();
    }
}

bool UApplicationThemePrivate::parseTheme()
{
    QDir dir(QApplication::applicationDirPath() + "/themes");
    auto infoList = dir.entryInfoList(QDir::Files);
    for (const auto &info : infoList)
    {
        QFile file(info.absoluteFilePath());
        if (!file.open(QFile::ReadOnly | QFile::Text))
        {
            qCritical() << "Error: Cannot read file " << info.fileName() << ": " << file.errorString();
            return false;
        }

        QString errorStr;
        int errorLine;
        int errorColumn;

        QDomDocument doc;
        if (!doc.setContent(&file, false, &errorStr, &errorLine, &errorColumn))
        {
            qCritical() << "Error: Parse error at line " << errorLine << ", "
                        << "column " << errorColumn << ": " << errorStr;
            return false;
        }

        QDomElement root = doc.documentElement();
        if (root.tagName() != "theme")
        {
            qCritical() << "Error: Not a theme file";
            return false;
        }

        QDomNode child = root.firstChild();
        int theme = 0;
        while (!child.isNull())
        {
            if (child.toElement().tagName() == "General")
            {
                parseGeneralTheme(theme, child.toElement());
            }
            else if (child.toElement().tagName() == "Palette")
            {
                parsePalette(theme, child.toElement());
            }
            child = child.nextSibling();
        }
    }

    return true;
}

bool UApplicationThemePrivate::parseGeneralTheme(int &theme, const QDomElement &dom)
{
    auto children = dom.childNodes();
    if (children.size() < 2)
    {
        return false;
    }
    auto firstChild = children.at(0).toElement();
    auto secordChild = children.at(1).toElement();
    theme = secordChild.text().toInt();
    themeMap.insert(secordChild.text().toInt(), firstChild.text());
    return true;
}

bool UApplicationThemePrivate::parsePalette(int &theme, const QDomElement &dom)
{
    QMap<int, QColor> colorMap;
    QDomNode child = dom.firstChild();
    while (!child.isNull())
    {
        QColor color = QColor(child.toElement().text());
        color.setAlphaF(child.toElement().attribute("opacity").toDouble());
        colorMap[child.toElement().attribute("index").toInt()] = color;
        child = child.nextSibling();
    }
    data->brushMap[theme] = colorMap;
    return true;
}

UApplicationTheme::UApplicationTheme(QObject* parent) : QObject(parent)
    , d_ptr(new UApplicationThemePrivate(this))
{
    Q_D(UApplicationTheme);
    d->initPaletteData();
}

UApplicationTheme::~UApplicationTheme()
{
}

void UApplicationTheme::setThemeName(const QString &theme)
{
    Q_D(UApplicationTheme);
    d->themeName = theme;
    emit themeNameChanged();
}

QString UApplicationTheme::themeName()
{
    Q_D(UApplicationTheme);
    return d->themeName;
}

void UApplicationTheme::setApplicationLanguage(int language)
{
    QString fileName = QString("%1/%2.ini").
                       arg(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)).arg(qApp->applicationName());

    QSettings settings(fileName, QSettings::IniFormat);
    settings.setValue("Settings/Language", language);
    settings.sync();
    emit applicationLanguageChanged();
}

void UApplicationTheme::setApplicationTheme(int theme)
{
    Q_D(UApplicationTheme);
    QString fileName = QString("%1/%2.ini").
                       arg(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)).arg(qApp->applicationName());

    QSettings settings(fileName, QSettings::IniFormat);
    settings.setValue("Settings/Theme", theme);
    settings.sync();
    setThemeName(theme > 1 ? "light" : d->themeMap[theme]);
    emit applicationThemeChanged();
}

int UApplicationTheme::applicationLanguage()
{
    QString fileName = QString("%1/%2.ini").
                       arg(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)).arg(qApp->applicationName());

    QSettings settings(fileName, QSettings::IniFormat);
    return settings.value("Settings/Language", QLocale::Chinese).toInt();
}

int UApplicationTheme::applicationTheme()
{
    QString fileName = QString("%1/%2.ini").
                       arg(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)).arg(qApp->applicationName());

    QSettings settings(fileName, QSettings::IniFormat);
    return settings.value("Settings/Theme", UApplicationTheme::LightTheme).toInt();
}

QColor UApplicationTheme::color(int ct)
{
    Q_D(UApplicationTheme);
    return d->data->brushMap[applicationTheme()][ct];
}

void UApplicationTheme::setHighlightColor(const QColor &color)
{
    Q_D(UApplicationTheme);
    for (const auto &key : d->themeMap.keys())
    {
        d->data->brushMap[key][UApplicationTheme::Highlight] = color;
    }
}

void UApplicationTheme::setColor(int theme, int ct, const QColor &color)
{
    Q_D(UApplicationTheme);
    d->data->brushMap[theme][ct] = color;
}
