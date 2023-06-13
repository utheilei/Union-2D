#include "themewindow.h"

ThemeWindow::ThemeWindow(QObject* parent) : QObject(parent)
{

}

ThemeWindow::ThemeType ThemeWindow::theme()
{
    return m_type;
}

void ThemeWindow::setTheme(const ThemeType &type)
{
    if (m_type != type)
    {
        m_type = type;
        emit themeChanged();
    }
}

QColor ThemeWindow::button()
{
    return QColor("#f5f5dc");
}

