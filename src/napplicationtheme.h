#ifndef NAPPLICATIONTHEME_H
#define NAPPLICATIONTHEME_H

#include <QObject>
#include <QColor>

class UApplicationThemePrivate;
class UApplicationTheme : public QObject
{
    Q_OBJECT
public:
    enum ThemeType
    {
        LightTheme,
        DarkTheme
    };
    Q_ENUM(ThemeType)

    enum CustomColorType
    {
        WindowText,
        Button,
        Light,
        Midlight,
        Dark,
        Mid,
        Text,
        BrightText,
        ButtonText,
        Base,
        Window,
        Shadow,
        Highlight,
        HighlightedText,
        Link,
        LinkVisited,
        AlternateBase,
        NoRole,
        ToolTipBase,
        ToolTipText,
        PlaceholderText,

        ItemBackground = 100,
        SuccessBackground,
        WarningBackground,
        ErrorBackground,
        OrangeBackground,
        OfflineBackground,
        InformationBackground,
        SplitLineBackground,
        FrameBorder
    };
    Q_ENUM(CustomColorType)

    Q_PROPERTY(QString themeName READ themeName WRITE setThemeName NOTIFY themeNameChanged)
    Q_PROPERTY(int applicationTheme READ applicationTheme WRITE setApplicationTheme NOTIFY applicationThemeChanged)
    Q_PROPERTY(int applicationLanguage READ applicationLanguage WRITE setApplicationLanguage NOTIFY applicationLanguageChanged)
    Q_PROPERTY(int highlightIndex READ highlightIndex WRITE setHighlightIndex NOTIFY highlightIndexChanged)

    explicit UApplicationTheme(QObject* parent = nullptr);
    ~UApplicationTheme();

    void setThemeName(const QString &theme);

    QString themeName();

    void setApplicationLanguage(int language);

    void setApplicationTheme(int theme);

    int applicationLanguage();

    int applicationTheme();

    void setHighlightIndex(int index);

    int highlightIndex();

    Q_INVOKABLE QColor color(int ct);

    Q_INVOKABLE void setHighlightColor(const QColor &color);

    Q_INVOKABLE void setColor(int theme, int ct, const QColor &color);

signals:
    void applicationThemeChanged();
    void applicationLanguageChanged();
    void themeNameChanged();
    void highlightIndexChanged();

private:
    QScopedPointer<UApplicationThemePrivate> d_ptr;
    Q_DECLARE_PRIVATE(UApplicationTheme)
};

#endif // NAPPLICATIONTHEME_H
