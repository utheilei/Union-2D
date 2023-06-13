#ifndef THEMEWINDOW_H
#define THEMEWINDOW_H

#include <QObject>
#include <QColor>

class ThemeWindow : public QObject
{
    Q_OBJECT
public:
    enum ThemeType
    {
        LightTheme,
        DarkTheme
    };
    Q_PROPERTY(ThemeType theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(QColor button READ button NOTIFY buttonColorChanged)
    explicit ThemeWindow(QObject* parent = nullptr);

    ThemeType theme();
    void setTheme(const ThemeType &type);

    QColor button();

signals:
    void themeChanged();
    void buttonColorChanged();

private:
    ThemeType m_type = ThemeType::LightTheme;

};

#endif // THEMEWINDOW_H
